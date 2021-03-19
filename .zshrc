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
PS1="%D %T 🌲 %F{220}%1~%f%b 🔥"

# Add git to the prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{220}(%b)%r%f'
zstyle ':vcs_info:*' enable git


export PATH="$HOME/scripts:$HOME/bin:$HOME/.cargo/bin:$PATH:."
export PKG_CONFIG_PATH="/usr/local/opt/sqlite/lib/pkgconfg:$HOME/usr/lib/pkgconfig:$PKG_CONFIGPATH"
export RUSTFLAGS="-C target-cpu=native"

