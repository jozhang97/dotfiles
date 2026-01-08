# Source bashrc
# if [ -f ~/.bashrc ]; then
#    source ~/.bashrc
# fi

function sbatchall() {
    for name in /u/jozhang/code/motion3d/scripts/runs/submit*.sh; do
        sbatch ${name}
    done
}

function sba() {
    for name in $(pwd)/submit*.sh; do
        sbatch ${name}
    done
}

function cba() {
    for name in $(pwd)/*.submit; do
        condor_submit ${name}
    done
}

alias sinfo="sinfo -S+P -o '%18P %8a %20F' -a"
alias tunnel="$SCRATCH/software/code tunnel"
alias tunnelc="$SCRATCH/software/cursor tunnel"
alias killpy="ps --user $(id -u) | grep 'python' | awk '{print $1}' | xargs -r kill -9"
alias sqlong='squeue -u $(whoami) -o "%.18i %64j  %.2t %.10M %R"'
function srunj() { srun --jobid=$1 --pty /bin/zsh }   # remember to unalias srunj

# MOVING DIRECTORIES STUFF
alias squeueme='squeue --format="%.18i %.9P %.2t %.10M %.6D" -u $(whoami) -a'
alias tt='tmux a -d'
alias profile='python -m cProfile -o $(pwd)/cprofile.prof $1'
alias sme='squeue -u $(whoami)'
alias watchme='watch -n 1 -d "squeue -u $(whoami) | wc -l && squeue -u $(whoami) -o \"%.18i %64j  %.2t %.10M %R\""'
alias watchlog='watch -n 1 -d cat /path/to/wandb/latest-run/files/output.log'

alias cgai='cd /scratch/projects/cgai'
alias cc='cd $HOME/code/jeffrey-internship'
alias inv='cd $HOME/code/InverseFold'
alias va='cd $HOME/code/VideoAppearance'
alias cs='cd $HOME/code/ContrastiveSeg'
alias ct='cd $HOME/code/CenterNet2/projects/CenterNet2'
alias ow='cd $HOME/code/OWT-dev/projects/CenterNet2'
alias home='cd "$HOME/code/motion3d"'
jump-to-project-folder() {
  cd "$HOME/code/$1"
}
alias pj=jump-to-project-folder

# SUDO INSERTION
alias please='eval "sudo $(fc -ln -1)"'

# DOCKER SHORTCUTS
function docker-attachh() {
    sudo docker exec -it $(docker ps -q)  bash
}

function docker-attach() {
    sudo docker exec -it "$1" bash
}

# SHORTCUTS
alias find='find . -name'
alias subll='subl $_'
alias howbig='du -sh'
alias pythonn="python gshield.py && python"
alias whichshell="echo $0"
alias hex='xxd -psd'
alias vimrc="vim ~/.vimrc"
alias edit="vim"
alias v="vim"
alias sl="ls"
alias dc="cd"
alias sa="source activate"
alias lss="ls -altr"
alias ns="watch -n 1 -d nvidia-smi"
alias mkdir="mkdir -p"     # -p make parent dirs as needed
alias df="df -h"           # -h prints human readable format
alias mv="mv -i"           # -i prompts before overwrite
alias cp="cp -i"           # -i prompts before overwrite
alias my-ip="curl ipinfo.io/ip 2> /dev/null"
alias time='watch -n 0.1 "date +"%H:%M%S"  | toilet -f bigmono9"'

alias gs="git status"
alias co="git checkout ."
alias grh="git reset HEAD "
alias ga="git add"
alias gp="git add -p"
alias gcm="git commit -m"
alias gd="git diff"
alias gdc="git diff --cached"
alias gpush="git push"
alias gpom="git push origin master"
alias gpull="git pull"
alias gl="git log"
alias ggrep="git grep"

alias tf="tail -f"


# GIT STUFF
git-checkout-menu() {
  local -a BRANCHES
  local -a COLORED_BRANCHES
  git-recent-branches | while read branch; do
    local date="$(git for-each-ref --sort=committerdate refs/heads/"$branch" --format='%(committerdate:relative)' --count=1)"
    local hash="$(git rev-list "$branch" --max-count=1)"
    case $branch in
      $(g-current-branch))
        COLORED_BRANCHES+=("\"$fg[magenta]* $fg[yellow]${branch}$fg[default] ($fg[green]$date$fg[default]) ${hash}\"");;
      *)
        COLORED_BRANCHES+=("\"$fg[white]${branch}$fg[default] ($fg[green]$date$fg[default]) ${hash}\"");;
    esac
    BRANCHES+=(${branch})
  done
  eval set $COLORED_BRANCHES
  select colored_br in "$@"
  do
    local br=$(echo ${BRANCHES[REPLY]})
    case $br in
      $(g-current-branch))
        echo "$fg[red]${br} is already checked out.";;
      *) git checkout $br;;
    esac
    break
  done
}
alias gcom=git-checkout-menu
# . "$HOME/.cargo/env"
