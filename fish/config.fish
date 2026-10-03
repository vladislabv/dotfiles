set -g fish_greeting

set -x EDITOR hx
set -x VISUAL hx

set -x PATH $HOME/.local/bin $PATH

if test -d /mnt/c/Users/vladi
    set -x PATH /mnt/c/Users/vladi/AppData/Local/Microsoft/WinGet/Packages $PATH
end

zoxide init fish | source
fzf --fish | source
