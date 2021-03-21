# You're annoying please stop
set -gx fish_greeting ''

# Add our scripts and our flatpaks
fish_add_path --global --prepend ~/bin ~/.local/share/flatpak/exports/bin

# If we have nvim then use it
if hash nvim &>/dev/null
    set -gx EDITOR nvim
    set -gx VISUAL nvim
end

set -gx PAGER less

# Set APORTSDIR and MANPAGER
set -gx APORTSDIR "$HOME"/Repositories/aports
command -q nvim; and set -gx MANPAGER "nvim -c 'set ft=man' -"

if test -n "$SSH_CLIENT"
    if test (echo -n "$SSH_CLIENT" | string split ' ' | tail -1) = 2222
        set -gx BROWSER 'flatpak-spawn --host firefox'
    end
end

if test -n "$TOOLBOX_PATH"
    set -gx BROWSER 'flatpak-spawn --host firefox'
end
