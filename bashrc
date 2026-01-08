# Vi bindings
set -o vi

# Editor
export EDITOR=vim
export VISUAL=vim

# Ignore history duplicates
export HISTCONTROL=ignoredups:erasedups

# Append to history instead of overwriting it
shopt -s histappend

# Increase history size
export HISTSIZE=100000
export HISTFILESIZE=100000

# Save and reload history after each command
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Conda
export PATH="$HOME/anaconda3/bin:$PATH"
export PATH="/opt/cuda-10.0/bin:$PATH"
export CUDA_PATH=/opt/cuda-10.0
export CUDA_HOME=/opt/cuda-10.0
export LD_LIBRARY_PATH=/opt/cuda-10.0/lib64:$LD_LIBRARY_PATH
export HF_HOME='/huggingface'


# Fuzzy Autocomplete
[ -f ~/.fzf.bash  ] && source ~/.fzf.bash

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/conda/etc/profile.d/conda.sh" ]; then
        . "/opt/conda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PYTHONPATH="/home1/07861/jozhang/code/ambient_proteins/genie2:/home1/07861/jozhang/code/ambient_proteins/insilico_design_pipeline"
export PATH="/scratch/projects/cgai/ambient_proteins/libs/bin:/home1/07861/jozhang/code/ambient_proteins:$PATH"
. "$HOME/.cargo/env"

alias gdrive=$SCRATCH/code/Infinity_dev/third_party/gdrive/target/debug/gdrive
export PATH="$HOME/.local/bin:$PATH"
