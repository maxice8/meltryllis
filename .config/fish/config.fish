# You're annoying please stop
set --global --export fish_greeting ''

# Add our scripts and our flatpaks
fish_add_path --global --prepend ~/bin ~/.local/share/flatpak/exports/bin

# Add go tools
fish_add_path --global --append ~/go/bin

# For Node
fish_add_path --global --append ./node_modules/.bin

# If we have nvim then use it
if hash nvim &>/dev/null
    set --global --export EDITOR nvim
    set --global --export VISUAL nvim
end

set --global --export PAGER less

# Set APORTSDIR and MANPAGER
set --global --export APORTSDIR "$HOME"/Repositories/aports
command -q nvim; and set --global --export MANPAGER "nvim -c 'set ft=man' -"

if test -n "$SSH_CLIENT"
    if test (echo -n "$SSH_CLIENT" | string split ' ' | tail -1) = 2222
        set --global --export BROWSER 'flatpak-spawn --host firefox'
    end
end

if test -n "$TOOLBOX_PATH"
    set --global --export BROWSER 'flatpak-spawn --host flatpak --user run org.mozilla.firefox'
end

# Set the gruvbox theme
theme_gruvbox dark hard
