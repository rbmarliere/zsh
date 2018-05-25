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
    rm -rf ~/.oh-my-zsh && ln -s ~/git/zsh/oh-my-zsh ~/.oh-my-zsh
    rm -rf ~/.vim && ln -s ~/git/zsh/vim ~/.vim
    find ~/git/zsh/dotfiles -name ".*" -not -path ~/git/zsh/dotfiles/.git -exec ln -s {} ~ \;
    source ~/.zshrc
}
