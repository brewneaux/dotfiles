# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt autocd extendedglob nomatch
setopt notify
setopt completeinword
setopt noglobdots
setopt inc_append_history

bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 4
zstyle :compinstall filename '/Users/jonathanbruno/dotfiles/zsh/zsh_completion'

autoload -Uz compinit
compinit

source ~/dotfiles/zsh/.aliases

# Colorize some stuff
autoload -U colors && colors
export CLICOLOR=1
# support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# prompt stuff
setopt promptsubst
setopt prompt_subst

# FUNCTIONS
build_git_prompt_section() {
    GIT_BRANCH=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'`
    if [ "$GIT_BRANCH" != '' ]; then
        GIT_STATUS="$(git status -s 2> /dev/null | sed '/^\?/ d' | wc -l | tr -d '[:space:]')"
        if [ "$GIT_STATUS" = 0 ]; then
            echo "%{$fg[green]%}$GIT_BRANCH%{$reset_color%}"
        else
            echo "%{$fg[red]%}$GIT_BRANCH%{$reset_color%}"
        fi
    fi
}


# Get battery stats ..... nanananananana
batstats(){
    GRML_BATTERY_LEVEL=''
    local -a table
    table=( ${$(pmset -g ps)[(w)7,8]%%(\%|);} )
    if [[ -n $table[2] ]] ; then
        case $table[2] in
            charging)
                GRML_BATTERY_LEVEL+="%{$fg[green]%}^"
                ;;
            discharging)
                if (( $table[1] < 20 )) ; then
                    GRML_BATTERY_LEVEL+="%{$fg[red]%}!v"
                else
                    GRML_BATTERY_LEVEL+="%{$fg[red]%}v"
                fi
                ;;
            *)
                ;;
        esac
        GRML_BATTERY_LEVEL+="$table[1]%"
    fi
    print "$GRML_BATTERY_LEVEL %{$reset_color%}"
}

PS1="%{$fg[red]%}mbp%{$reset_color%} @ %{$fg[blue]%}%0/ %{$FG[248]%}% : "
PS1+='$(build_git_prompt_section)'
PS1+="
 $ %{$reset_color%}% "



RPROMPT='[$(batstats)]'

function zle-line-init zle-keymap-select {
    RPS1="[$(batstats)] ${${KEYMAP/vicmd/N}/(main|viins)/I}"
    RPS2=$RPS1

    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select


# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
