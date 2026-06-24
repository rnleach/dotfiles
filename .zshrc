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

# set PATH so it includes user's scripts if it exists
if [ -d "$HOME/scripts" ] ; then
    PATH="$HOME/scripts:$PATH"
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

# set up for intel compiler if it exists
if [ -d "/opt/intel/oneapi" ] ; then
    source /opt/intel/oneapi/setvars.sh > /dev/null 2>&1
fi

# add current directory to the path
PATH=".:$PATH"

export PATH

if [ -d "/usr/local/opt/sqlite/lib/pkgconfg" ] ; then
    PKG_CONFIG_PATH="/usr/local/opt/sqlite/lib/pkgconfg:$PKG_CONFIG_PATH"
fi

if [ -d "$HOME/usr/lib/pkgconfig" ] ; then
    PKG_CONFIG_PATH="$HOME/usr/lib/pkgconfig:$PKG_CONFIG_PATH"
fi

export PKG_CONFIG_PATH

# Aliases
if [ -x "$(command -v exa)" ]; then
    alias ls='exa -h'
    alias ll='exa -lh'
fi
alias ssh='TERM=xterm-256color ssh'

alias cfmt='clang-format --style=file --verbose -i **/*.c **/*.h'

