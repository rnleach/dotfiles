# case insensitive globs
setopt NO_CASE_GLOB

# History
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=10000
HISTSIZE=2000
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

# Aliases
alias ls='exa -h'
alias ll='exa -lh'

alias cfmt='clang-format --style=file --verbose -i **/*.c **/*.h'

# Set up the prompt
PS1="%B⚡%D %T 🌲 %F{221}%1~%f%b 🔥"

# Add git to the prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{220}(%b)%r%f'
zstyle ':vcs_info:*' enable git

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

if [ -d "$HOME/bin:$PATH" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's scripts if it exists
if [ -d "$HOME/scripts" ] ; then
    PATH="$HOME/scripts:$PATH"
fi
export PATH

if [ -d "/usr/local/opt/sqlite/lib/pkgconfg" ] ; then
    PKG_CONFIG_PATH="/usr/local/opt/sqlite/lib/pkgconfg:$PKG_CONFIGPATH"
fi

if [ -d "$HOME/usr/lib/pkgconfig" ] ; then
    PKG_CONFIG_PATH="$HOME/usr/lib/pkgconfig:$PKG_CONFIGPATH"
fi
export PKG_CONFIG_PATH
