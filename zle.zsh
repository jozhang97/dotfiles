# Bind \eg to `git status`
function _git-status {
    zle kill-whole-line
        zle -U "git status"
            zle accept-line

}
zle -N _git-status
bindkey '\eg' _git-status
