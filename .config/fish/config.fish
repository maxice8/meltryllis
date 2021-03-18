# You're annoying please stop
set -gx fish_greeting ''

# Set a SANE path
set -gx PATH /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /bin /sbin

# Version 3.2.0 and above has fish_add_path
if test (echo $FISH_VERSION | tr -d '.') -gt 320
    fish_add_path -p ~/bin ~/.local/share/flatpak/exports/bin
else
    set -gx PATH ~/bin ~/.local/share/flatpak/exports/bin $PATH
end

# If we have nvim then use it
if hash nvim &>/dev/null
    set -gx EDITOR nvim
    set -gx VISUAL nvim
end

# Set APORTSDIR and MANPAGER
set -gx APORTSDIR "$HOME"/Repositories/aports
set -gx MANPAGER "nvim -c 'set ft=man' -"

if test -n "$SSH_CLIENT"
    if test (echo -n "$SSH_CLIENT" | string split ' ' | tail -1) = 2222
        set -gx BROWSER 'flatpak-spawn --host firefox'
    end
end

if test -n "$TOOLBOX_PATH"
    set -gx BROWSER 'flatpak-spawn --host firefox'
end
