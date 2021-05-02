# Load SSH and PGP keys using keychain
eval $(keychain --eval --quiet git_ssh 909C6EA799D40276 --agents ssh,gpg)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Zsh Settings
#

# Load colors
autoload -U colors && colors

# Zstyle
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZDOTDIR/.zcompcache"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' rehash true

# History
export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=10000

# Options
setopt append_history           # Append history list to the history file, rather than replace it
setopt inc_append_history       # Write to the history file immediately, not when the shell exits
setopt share_history            # Share history between all sessions
setopt hist_expire_dups_first   # Expire a duplicate event first when trimming history
setopt hist_ignore_dups         # Do not record an event that was just recorded again
setopt hist_ignore_all_dups     # Delete an old recorded event if a new event is a duplicate
setopt hist_find_no_dups        # Do not display a previously found event
setopt hist_ignore_space        # Do not record an event starting with a space
setopt hist_save_no_dups        # Do not write a duplicate event to the history file
setopt hist_verify              # Do not execute immediately upon history expansion
setopt extended_history         # Show timestamp in history
setopt extended_glob            # Use extended globbing
setopt auto_cd                  # Automatically change directory if a directory is entered
setopt notify                   # Report the status of background jobs immediately

#
# Aliases
#

alias ls='ls --color=auto'
alias ll='ls --color=auto -l --almost-all --human-readable'
alias df='df --human-readable'
alias du='du --human-readable'
alias cp='cp --verbose'
alias mv='mv --verbose'
alias ln='ln --verbose'
alias exal='exa --long --all --binary --header'
alias ip='ip --color'
alias ncdu='ncdu -rr --color dark'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

#
# Zinit
#

if [[ ! -f $ZDOTDIR/.zinit/bin/zinit.zsh ]]; then
  command mkdir -p "$ZDOTDIR/.zinit" && command chmod g-rwX "$ZDOTDIR/.zinit"
  command git clone https://github.com/zdharma/zinit "$ZDOTDIR/.zinit/bin"
fi

source "$ZDOTDIR/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Keybindings from OMZL
zinit ice silent light
zinit snippet OMZL::key-bindings.zsh

# Powerlevel10k
zinit lucid light-mode atload'!source $ZDOTDIR/.p10k.zsh' id-as'powerlevel10k' for \
  romkatv/powerlevel10k

# OMZ Plugins and Libs
zinit wait lucid light-mode for \
  OMZL::termsupport.zsh \
  OMZP::git/git.plugin.zsh \
  OMZP::gitignore/gitignore.plugin.zsh

# LS_COLORS
zinit wait lucid light-mode from'gh' atclone'dircolors -b LS_COLORS > clrs.zsh' \
  atpull'%atclone' pick'clrs.zsh' nocompile'!' \
  atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”' for \
    trapd00r/LS_COLORS

# Path to zsh completion scripts
fpath=( $ZDOTDIR/.zfunc $fpath )

# Fast-syntax-highlighting & autosuggestions
zinit wait lucid light-mode for \
  atinit'ZINIT[COMPINIT_OPTS]=-C' \
    zdharma/fast-syntax-highlighting \
  atload'!_zsh_autosuggest_start' \
    zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall zsh-users/zsh-autosuggestions' atload'zicompinit; zi cdreplay -q' \
    zsh-users/zsh-completions

#
# Add Programs to $PATH
#

# zoxide
zinit wait lucid light-mode from'gh-r' id-as'zoxide' as'program' mv'zoxide* -> zoxide' \
  atclone'./zoxide init zsh --no-aliases > zoxide.zsh' atpull'%atclone' \
  pick'zoxide' src='zoxide.zsh' for \
    ajeetdsouza/zoxide

# zoxide aliases
z() {
  if [[ $1 == "-i" ]]; then
    __zoxide_zi ${@:2}
  else
    __zoxide_z ${@:1}
  fi
}

# Direnv
zinit wait lucid light-mode from'gh-r' id-as'direnv' as'program' mv'direnv* -> direnv' \
  atclone'./direnv hook zsh > direnv_hook.zsh' atpull'%atclone' \
  pick'direnv' src='direnv_hook.zsh' for \
    direnv/direnv

# delta
zinit wait lucid light-mode from'gh-r' id-as'delta' as'program' \
  mv'delta*/delta -> delta' pick'delta' for \
    dandavison/delta

