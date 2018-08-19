export PATH=${HOME}/bin:${PATH}
export EDITOR=vim
export GPG_TTY=$(tty)
export KEYTIMEOUT=1
export USER_GIT_ROOT=${HOME}/git

HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
ZSH_THEME="kphoen"

plugins=(vi-mode git zsh-completions zsh-dircolors-solarized)

unsetopt nomatch
autoload -U colors && colors
autoload -U compinit promptinit
compinit
promptinit

source ${ZSH}/oh-my-zsh.sh

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg_bold[blue]%}"
PROMPT='[%{$fg[red]%}$(date +%T) %{$fg_bold[yellow]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}$(git_prompt_info)]
%# '
TPUT_END=$(tput cup 9999 0)
PS1="${TPUT_END}${PS1}"

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{${fg_bold[yellow]}%} [% NORMAL]%  %{${reset_color}%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} ${EPS1}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

alias ..="cd .."
alias cdg="cd ${USER_GIT_ROOT}"
alias g="git"
alias pa="php artisan"
alias ptpb="curl https://ptpb.pw -F c=@-"
alias s="source"
alias sz="source ${HOME}/.zshrc"
alias vi="vim"

[ -f ${HOME}/.localrc ] && source ${HOME}/.localrc

envset() {
    if [ -d ${HOME}/git/zsh ]; then
        pwd=$(pwd)
        cd ${HOME}/git/zsh
        git pull origin
        git submodule update --recursive --init
        cd ${pwd}
    fi
    rm -rf ${HOME}/.oh-my-zsh && ln -s ${HOME}/git/zsh/oh-my-zsh ${HOME}/.oh-my-zsh
    rm -rf ${HOME}/.vim && ln -s ${HOME}/git/zsh/vim ${HOME}/.vim
    find ${HOME}/git/zsh/dotfiles -name ".*" -not -path ${HOME}/git/zsh/dotfiles/.git -exec ln -s {} ${HOME} \;
    source ${HOME}/.zshrc
}

t() {
    SESSIONNAME="main"
    tmux has-session -t $SESSIONNAME &> /dev/null
    [ $? != 0 ] && tmux new-session -s $SESSIONNAME -d
    tmux attach -t $SESSIONNAME
}

