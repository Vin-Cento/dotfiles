# making it prettier
# if [[ $TERM == xterm-kitty ]]; then TERM=xterm-256color; fi
set t_Co=256

# History in cache directory:
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.cache/.zsh_history

# tmux and zsh history sync
setopt CORRECT
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY

zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_DATA_HOME/zsh/.zcompcache"
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' group-name ''
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.

# Basic auto/tab complete:
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
complete -C '/usr/bin/aws_completer' aws


# cd with just Filename
setopt autocd

source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/zsh-colored-man-pages/zsh-colored-man-pages.zsh
source $ZDOTDIR/aws_zsh_completer.zsh
source $ZDOTDIR/lfcd.sh
# source $ZDOTDIR/wp-completion.bash

# ansible
export ANSIBLE_HOST_KEY_CHECKING=False

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

### SpaceShip settings ###

# using spaceship
source $ZDOTDIR/spaceship-prompt/spaceship.zsh

# fzf setup
source $ZDOTDIR/fzf/completion.zsh
source $ZDOTDIR/fzf/key-bindings.zsh

### Personal list of alias ###

# better command alternative
alias s='bat'
alias tree='tree --dirsfirst -C'
alias diff='diff --color'
alias grep='grep --color'
# faster
alias l='exa --icons -lh --group-directories-first'
alias ll='exa --icons -lh --grid --group-directories-first'
alias la='exa --icons --group-directories-first -lah --grid'
alias v='nvim'
alias gitd='/usr/bin/git --git-dir=$HOME/.cfg/.git/ --work-tree=$HOME'
alias gl='git log --all --decorate --graph'

source $ZDOTDIR/aliases

eval "$(lua ~/.config/zsh/z.lua/z.lua --init zsh enhanced once)"
_SILENT_JAVA_OPTIONS="$_JAVA_OPTIONS" && unset _JAVA_OPTIONS && alias java='java "$_SILENT_JAVA_OPTIONS"'
