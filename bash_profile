# Source bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi


# MOVING DIRECTORIES STUFF
jump-to-project-folder() {
  cd "$HOME/code/$1"
}
alias pj=jump-to-project-folder

# SUDO INSERTION
alias please='eval "sudo $(fc -ln -1)"'

# CONNECT WITH REMOTE SERVER
function imageme() {
    curl https://cdn.rawgit.com/unwitting/imageme/master/imageme.py | sudo python2
}

function jlab() {
    jupyter lab --ip louis.eecs.berkeley.edu --port 8889 --allow-root
}

function tb() {
    PORT=${1:-6006}
    tensorboard --logdir=. --port=${PORT} --host=${hostname}.eecs.berkeley.edu
}

function sync() {
    remote=$1
    dir=$2
    # Sends code/data from local to remote instance (up to the cloud)
    rsync -avx -e 'ssh ' * jeffrey@${remote}.eecs.berkeley.edu:~/$2/.
}

# DOCKER SHORTCUTS
function docker-attachh() {
    sudo docker exec -it $(docker ps -q)  bash
}

function docker-attach() {
    sudo docker exec -it $1 ash
}

# SHORTCUTS
alias whichshell="echo $0"
alias vimrc="vim ~/.vimrc"
alias edit="vim"
alias v="vim"
alias sl="ls"
alias sa="source activate"
alias lss="ls -altr"
alias ns="watch -n 1 -d nvidia-smi"
alias mkdir="mkdir -p"     # -p make parent dirs as needed
alias df="df -h"           # -h prints human readable format
alias mv="mv -i"           # -i prompts before overwrite

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



# GIT STUFF
g-current-branch() { git rev-parse --abbrev-ref HEAD | tr -d '\n' }
git-recent-branches() { git for-each-ref --count=10 --sort=-committerdate refs/heads/ --format="%(refname:short)" }
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
# see changes of current working state with HEAD
seePrevChanges() {
  git diff HEAD^ $1
}
# show all the changes from current branch to master
seeChangesFromMaster() {
    branchName=$(getBranchName)
    if [ "$#" -eq 1 ]; then
      baseBranch=$1
    else
      baseBranch="master"
    fi
    git diff $branchName..$baseBranch
}
# show which files have been changed from current branch to master
seeFileChangesFromMaster() {
    branchName=$(getBranchName)
    if [ "$#" -eq 1 ]; then
      baseBranch=$1
    else
      baseBranch="master"
    fi
    git diff --name-status $branchName..$baseBranch
}
alias gcom=git-checkout-menu

alias git-changes-master=seeChangesFromMaster
alias git-changes-master-files=seeFileChangesFromMaster
alias git-changes-file=seePrevChanges # see changes for a single file
