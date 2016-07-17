# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt autocd extendedglob nomatch
setopt notify
setopt completeinword
setopt noglobdots
setopt inc_append_history


setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.


eval $(dircolors ~/dotfiles/dircolors-solarized/dircolors.256dark)

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
    bat_display=''
    integer charge_level=$(acpi -b | awk '{print $4}' | sed s/%,//g)
    case $(acpi -b | awk '{print $3}' | grep -ci dis) in
        1)
            if (( $charge_level < 20 )); then
                bat_display+="%{$fg[red]%}!!!v"
            else
                bat_display+="%{$fg[red]%}v"
            fi
            ;;
        *)
            bat_display+="%{$fg[green]%}^"
    esac
  

    print "${bat_display}${charge_level}%{$reset_color%}"
}

PS1="%{$fg[red]%}local%{$reset_color%} @ %{$fg[blue]%}%0/ %{$FG[248]%}% : "
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
