# case insensitive globs
setopt NO_CASE_GLOB

# History
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=10000
HISTSIZE=2000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

# Aliases
if [ -x "$(command -v exa)" ]; then
    alias ls='exa -h'
    alias ll='exa -lh'
fi
alias ssh='TERM=xterm-256color ssh'

alias cfmt='clang-format --style=file --verbose -i **/*.c **/*.h'

# Add git to the prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{220}(%b)%f'
zstyle ':vcs_info:*' enable git

# Set up the prompt
PS1="%B %F{117}%m ⚡%W %T%f 🌲 %F{220}%1~%f%b 🔥 :"

autoload -Uz compinit && compinit

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Default to compile for native
export RUSTFLAGS="-C target-cpu=native"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Add cargo to the path
if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/usr/bin" ] ; then
    PATH="$HOME/usr/bin:$PATH"
fi

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's scripts if it exists
if [ -d "$HOME/scripts" ] ; then
    PATH="$HOME/scripts:$PATH"
fi

export PATH

if [ -d "/usr/local/opt/sqlite/lib/pkgconfg" ] ; then
    PKG_CONFIG_PATH="/usr/local/opt/sqlite/lib/pkgconfg:$PKG_CONFIG_PATH"
fi

if [ -d "$HOME/usr/lib/pkgconfig" ] ; then
    PKG_CONFIG_PATH="$HOME/usr/lib/pkgconfig:$PKG_CONFIG_PATH"
fi

export PKG_CONFIG_PATH

# Set up some directories for my satellite data.
if [ -d "$HOME/wxdata" ] ; then
    CLUSTER_DB="$HOME/wxdata/operational_findfire.sqlite"
    export CLUSTER_DB
    FIRES_DB="$HOME/wxdata/operational_connectfire.sqlite"
    export FIRES_DB
fi

if [ -d "/media/ryan/SAT/GOES" ] ; then
    SAT_ARCHIVE="/media/ryan/SAT/GOES"
    export SAT_ARCHIVE
elif [ -d "/Volumes/MET2/GOES" ] ; then
    SAT_ARCHIVE="/Volumes/MET2/GOES"
    export SAT_ARCHIVE
elif [ -d "/home/ryan/wxdata/GOES" ] ; then
    SAT_ARCHIVE="/home/ryan/wxdata/GOES"
    export SAT_ARCHIVE
fi
