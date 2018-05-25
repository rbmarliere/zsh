export PATH=~/bin:~/.yarn/bin:~/.node/bin:~/.config/composer/vendor/bin:~/.composer/vendor/bin:/usr/local/bin:${PATH}
export EDITOR=vim
export GPG_TTY=$(tty)
export ZSH=~/.oh-my-zsh
export KEYTIMEOUT=1
export USER_GIT_ROOT=~/git

HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
ZSH_THEME="kphoen"
plugins=(vi-mode git zsh-completions zsh-dircolors-solarized)

autoload -U colors && colors
autoload -U compinit promptinit
compinit
promptinit

source ${ZSH}/oh-my-zsh.sh
PROMPT='[%{$fg[green]%}$(date +%T) %{$fg[red]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}$(git_prompt_info)]
%# '

TPUT_END=$(tput cup 9999 0)
PS1="${TPUT_END}${PS1}"

precmd() { RPROMPT="" }
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
alias sz="source ~/.zshrc"
alias vi="vim"

[ -f ~/.localrc ] && source ~/.localrc

env_setup() {
    [ -d ~/.oh-my-zsh ] || git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    if [ -d ~/.vim ]; then
        [ -d ~/.vim/sessions ] && mv ~/.vim/sessions ~
        rm -rf ~/.vim
    fi
    git clone --recursive https://github.com/rbmarliere/vim.git ~/.vim
    mkdir -p ~/.vim/{bkp,swp}
    [ -d ~/sessions ] && mv ~/sessions ~/.vim || mkdir -p ~/.vim/sessions
    rm ~/.vimrc && ln -s ~/.vim/vimrc ~/.vimrc
    source ~/.zshrc
}
