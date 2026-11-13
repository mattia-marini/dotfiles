# env.nu
#
# Nushell environment configuration, ported from ~/.config/fish/config.fish.
# This file is loaded before config.nu.

# ---------------------------------------------------------------------------
# PATH
#
# Ported from the `fish_add_path` calls and `fish_user_paths` in the Fish
# config. Prepended in the same order Fish used.
# ---------------------------------------------------------------------------
$env.PATH = ([
    "/home/mattia/Desktop/russell/marini-didattica/workspace-meta/bin"
    "/home/mattia/Desktop/russell/materiale/workspace-meta/bin"
    "/home/mattia/.local/bin"
    "/home/mattia/.bun/bin"
] ++ $env.PATH | uniq)

# ---------------------------------------------------------------------------
# Environment variables
# ---------------------------------------------------------------------------
$env.EDITOR = "nvim"
$env.MPD_HOST = "/tmp/mpd_socket"

# ---------------------------------------------------------------------------
# Skim (fzf-like fuzzy finder)
#
# These were only set for interactive Fish shells. The keybindings that use
# them live in config.nu.
# ---------------------------------------------------------------------------
if $nu.is-interactive {
    $env.SKIM_DEFAULT_COMMAND = "fd --type f --hidden --exclude .git"
    $env.SKIM_CTRL_T_COMMAND = "fd --type f --hidden --exclude .git"
    $env.SKIM_ALT_C_COMMAND = "fd --type d --hidden --exclude .git"
}

# ---------------------------------------------------------------------------
# Starship prompt
#
# `starship.nu` was generated with `starship init nu`. Regenerate it after a
# Starship update with:
#     starship init nu | save -f ~/.config/nushell/starship.nu
#
# NOTE: Starship's `enable_transience` has no Nushell equivalent.
# ---------------------------------------------------------------------------
source ($nu.default-config-dir | path join "starship.nu")

# ---------------------------------------------------------------------------
# mise
#
# Official Nushell setup: regenerate the activation module on every startup so
# it follows mise upgrades, then load it from config.nu.
#     https://mise.jdx.dev/shell-setup.html#nushell
# ---------------------------------------------------------------------------
let mise_path = $nu.default-config-dir | path join "mise.nu"
if (which mise | is-not-empty) {
    ^mise activate nu | save --force $mise_path
}
