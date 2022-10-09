# set XDG variables.
# source: https://wiki.archlinux.org/index.php/XDG_Base_Directory

export XDG_CONFIG_HOME="${HOME}/.config" 
export XDG_CACHE_HOME="${HOME}/.cache" 
export XDG_DATA_HOME="${HOME}/.local/share" 

#export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ZSH="/usr/share/zsh/custom"

# History
#export HISTFILE="${ZDOTDIR}/.zhistory"    # History filepath
export HISTSIZE=50000
export SAVEHIST=10000

export XCOMPOSEFILE="${XDG_CONFIG_HOME}/X11/xcompose"
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"

export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/rg/ripgreprc"

# Compilation flags
# lscpu | awk 'BEGIN { l=j=1 } /(Core|Thread)\(s\)/ { l=l*$NF } END { j=l+1; print "-j"j,"-l"l }'
export MAKEFLAGS="-j$(nproc)"

# disable LESSHISTFILE
export LESSHISTFILE=-

# default editor
export EDITOR=vim
export VISUAL=vim

# hostname
export HOSTNAME=$(</etc/hostname)

# virsh: allow user to run without sudo
export VIRSH_DEFAULT_CONNECT_URI="qemu:///system"
