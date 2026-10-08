# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc


alias i='sudo dnf install'
alias u='sudo dnf update'
alias r='sudo dnf remove'
alias pr='cd /home/adham/ai/Projects && ls'
alias dot='cd $HOME/dotfiles/'
#flutter
export PATH="$PATH:/home/adham/dev/flutter_linux_3.29.3-stable/flutter/bin"
export PATH="$HOME/Android/Sdk/platform-tools:$PATH"
