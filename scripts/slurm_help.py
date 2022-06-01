#!/lusr/bin/python3

# Courtesy of Brady Zhou, for the UT dgx cluster
import subprocess
import pathlib
import time


INFO = 'sinfo -O nodehost,gres,cpusstate,freemem,allocmem,memory'
QUEUE = 'squeue -O username,state,nodelist,gres,minmemory,numcpus'


def run(command, dry=False):
    print(command)

    x = ''

    try:
        if not dry:
            x = subprocess.check_output(command.split()).decode('utf-8').strip()
    except Exception as e:
        print(e)
        print(f'"{command}" failed.\n')

    return x


def parse_memory_string(s):
    suffixes = {'M': 1.0 / 1e3, 'G': 1.0}
    result = 0

    for x in s:
        if x in suffixes:
            result *= suffixes[x]
        else:
            result = 10.0 * result + int(x)

    return int(result)


def get_info():
    output = run(INFO).strip().split('\n')[1:]
    result = dict()

    for line in output:
        name, gpus_unparsed, cpus, free, alloc, mem = line.split()

        try:
            free = int(float(free) / 1000)
        except:
            free = -1

        alloc = int(float(alloc) / 1000)
        mem = int(float(mem) / 1000)
        _, idle, _, _ = list(map(int, cpus.split('/')))

        result[name] = dict()
        result[name]['gpus'] = int(gpus_unparsed.split(':')[-1])
        result[name]['mem'] = mem
        result[name]['mem_free'] = min(free, mem - alloc)
        result[name]['cpus'] = idle

    return result


def get_running():
    output = run(QUEUE).strip().split('\n')[1:]
    result = dict()

    for line in output:
        if len(line.split()) == 5:
            continue

        user, state, name, gpus_unparsed, memory_unparsed, cpus = line.split()
        gpus = gpus_unparsed.split(':')[-1]
        gpus = int(gpus != '(null)') and int(gpus)
        memory = parse_memory_string(memory_unparsed)

        if state in ['RUNNING', 'COMPLETING']:
            for key in [name, user]:
                if key not in result:
                    result[key] = {'gpus': 0, 'mem': 0, 'cpus': 0}

                result[key]['gpus'] += gpus
                result[key]['mem'] += memory
                result[key]['cpus'] += int(cpus)

    return result


def pprint(machines):
    for i, (name, specs) in enumerate(machines):
        if i == 0:
            tokens = ' '.join([f'{"name".upper():>15}'] + [f'{key.upper():>{len(key)+4}}' for key in sorted(specs)])

            print(len(tokens) * '=')
            print(tokens)
            print(len(tokens) * '=')

        result = [f'{name:>15}']

        for key, val in sorted(specs.items()):
            result.append(f'{val:>{len(key)+4}}')

        print(' '.join(result))



info = get_info()
running = get_running()
remainder = {k: dict(v) for k, v in info.items()}

for name in info:
    if name not in running:
        continue

    remainder[name]['gpus'] -= running[name]['gpus']
    remainder[name]['mem'] -= running[name]['mem']

leftovers = [(k, v) for k, v in sorted(remainder.items())]
available = [(k, v) for k, v in sorted(remainder.items()) if all(x > 0 for x in v.values())]
full = [(k, v) for k, v in sorted(remainder.items()) if any(x < 1e-5 for x in v.values())]
users = [(k, v) for k, v in sorted(running.items()) if k not in info]

for k, v in users:
    for kk in ['cpus', 'mem']:
        if v['gpus'] == 0:
            v[f'{kk}/GPU'] = '-'
        else:
            v[f'{kk}/GPU'] = round(v[kk] / v['gpus'])

# pprint(available)
# pprint(full)

pprint(leftovers)
pprint(users)

idle = sum(v['gpus'] for v in remainder.values())
total = sum(v['gpus'] for v in info.values())

print()
print(f'GPUS idle: {idle} / {total}')

