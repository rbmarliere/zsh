export PATH=${HOME}/bin:${HOME}/.local/bin:${PATH}
export EDITOR=vim
export GPG_TTY=$(tty)
export KEYTIMEOUT=1
export USER_GIT_ROOT=${HOME}/git
export ZSH=${USER_GIT_ROOT}/zsh/oh-my-zsh

alias cdg="cd ${USER_GIT_ROOT}"
alias g="git"
alias ptpb="curl https://ptpb.pw -F c=@-"
alias sz="source ${HOME}/.zshrc"
alias vi="vim"

fpath=(
    ${USER_GIT_ROOT}/zsh/zsh-plugins/cleos-zsh-completion
    ${USER_GIT_ROOT}/zsh/zsh-plugins/zsh-completions/src
    "${fpath[@]}"
)
plugins=(
    vi-mode
    git
)
source ${ZSH}/oh-my-zsh.sh
source ${USER_GIT_ROOT}/zsh/zsh-plugins/zsh-dircolors-solarized/zsh-dircolors-solarized.zsh
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
ZSH_THEME="kphoen"
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
PROMPT='[%{$fg[red]%}$(date +%T) %{$fg[yellow]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}:%{$fg[cyan]%}%~%{$reset_color%}$(git_prompt_info)]
%# '
TPUT_END=$(tput cup 9999 0)
PS1="${TPUT_END}${PS1}"
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{${fg_bold[yellow]}%} [% NORMAL]%  %{${reset_color}%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} ${EPS1}"
    zle reset-prompt
}
autoload -Uz compinit promptinit
compinit
promptinit

function envset {
    if [ -d ${USER_GIT_ROOT}/zsh ]; then
        pwd=$(pwd)
        cd ${USER_GIT_ROOT}/zsh
        git pull origin
        git submodule update --recursive --init
        cd ${pwd}
    fi
    rm -rf ${HOME}/.oh-my-zsh && ln -s ${USER_GIT_ROOT}/zsh/oh-my-zsh ${HOME}/.oh-my-zsh
    rm -rf ${HOME}/.vim && ln -s ${USER_GIT_ROOT}/zsh/vim ${HOME}/.vim
    find ${USER_GIT_ROOT}/zsh/dotfiles -maxdepth 1 -name ".*" -not -path ${USER_GIT_ROOT}/zsh/dotfiles/.git -exec ln -s {} ${HOME} \;
    rm -f ${HOME}/.zcompdump*
    source ${HOME}/.zshrc
}

[ -f ${HOME}/.localrc ] && source ${HOME}/.localrc

