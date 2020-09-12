# TODO Read this
import os
import sys
import GPUtil
limit = int(sys.argv[1]) if len(sys.argv) > 1 else 1000
requested_limit = (len(sys.argv) > 1)
# If you need one GPU, I will pick it here for you
gpu = [str(g) for g in GPUtil.getAvailable(maxMemory=0.2, limit=limit)]
if 'CUDA_VISIBLE_DEVICES' not in os.environ or not os.environ['CUDA_VISIBLE_DEVICES']:
    assert len(gpu) > 0, 'No available GPUs'
    assert len(gpu) >= limit, 'Not enough available GPUs ({} < {})'.format(len(gpu), limit)
    print('Using GPU', ','.join(gpu))
    os.environ['CUDA_VISIBLE_DEVICES'] = ','.join(gpu)
gpus = GPUtil.getGPUs()
gpu_avail = GPUtil.getAvailability(gpus, maxMemory=0.2)
free_gpus = [str(i) for i in range(len(gpu_avail)) if gpu_avail[i] > 0]
requested_gpus=os.environ['CUDA_VISIBLE_DEVICES'].split(",")
if requested_limit:
    assert len(requested_gpus) >= limit, "{} gpus requested from script, but only {} available from CUDA_VISIBLE_DEVICES".format(limit, len(requested_gpus))
assert all([g in free_gpus for g in requested_gpus]), "{} not subset of {}".format(requested_gpus, free_gpus)
