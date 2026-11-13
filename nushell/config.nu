# config.nu
#
# Nushell configuration, ported from ~/.config/fish/config.fish.
# Environment variables and PATH live in env.nu.

# ---------------------------------------------------------------------------
# Machine-specific config
#
# Equivalent of Fish's `source $config_dir/system.fish`. Nushell `source` is
# resolved at parse time, so `system.nu` must exist (it can be empty).
# ---------------------------------------------------------------------------
source ($nu.default-config-dir | path join "system.nu")

# ---------------------------------------------------------------------------
# Completions
#
# Fish ran `eval (starship completions fish)`. `starship completions nushell`
# was saved to completions/starship.nu. Regenerate after a Starship update:
#     starship completions nushell | save -f ~/.config/nushell/completions/starship.nu
# ---------------------------------------------------------------------------
source ($nu.default-config-dir | path join "completions" "starship.nu")

# ---------------------------------------------------------------------------
# Editing mode
#
# Fish used `fish_vi_key_bindings default` via the `my_f` function, and a block
# cursor (`fish_term_cursor_style block`).
# ---------------------------------------------------------------------------
$env.config.edit_mode = "vi"
$env.config.cursor_shape.vi_insert = "block"
$env.config.cursor_shape.vi_normal = "block"
$env.config.cursor_shape.vi_visual = "block"

# Fish greeting was disabled (`set fish_greeting ""`).
$env.config.show_banner = false

# ---------------------------------------------------------------------------
# Theme: everforest
#
# Ported from `fish_config theme choose everforest`.
# Palette: https://github.com/sainnhe/everforest
# ---------------------------------------------------------------------------
$env.config.color_config = ($env.config.color_config | merge {
    header: { fg: "#A7C080" attr: "b" }
    separator: "#859289"

    bool: "#7FBBB3"
    int: "#A7C080"
    float: "#A7C080"
    string: "#A7C080"
    nothing: "#7FBBB3"
    binary: "#A7C080"
    binary_printable: "#A7C080"
    binary_non_ascii: "#A7C080"
    binary_ascii_other: "#A7C080"
    binary_whitespace: "#A7C080"
    binary_null_char: "#7FBBB3"
    datetime: "#DBBC7F"
    date: "#DBBC7F"
    filesize: "#83C092"
    duration: "#DBBC7F"
    range: "#DBBC7F"
    semver: "#DBBC7F"
    semver-range: "#DBBC7F"
    glob: "#DBBC7F"
    cell-path: "#83C092"
    record: "#7FBBB3"
    list: "#7FBBB3"
    block: "#7FBBB3"
    closure: "#7FBBB3"
    empty: "#7FBBB3"
    hints: "#859289"
    row_index: { fg: "#A7C080" attr: "b" }
    leading_trailing_space_bg: { attr: "n" }

    # Selection / search
    selection: { fg: "#D3C6AA" bg: "#543A48" }
    selection_cursor: { fg: "#2D353B" bg: "#A7C080" }
    search_result: { fg: "#2D353B" bg: "#A7C080" }

    # Status line
    status_line: "#859289"
    status_line_error: "#E67E80"

    # Syntax shapes
    shape_garbage: { fg: "#E67E80" attr: "u" }
    shape_matching_brackets: { attr: "b" }
    shape_external: "#7FBBB3"
    shape_externalarg: "#7FBBB3"
    shape_external_resolved: "#83C092"
    shape_internalcall: "#E67E80"
    shape_keyword: "#E67E80"
    shape_operator: "#E69875"
    shape_pipe: "#E69875"
    shape_redirection: "#DBBC7F"
    shape_directory: "#A7C080"
    shape_filepath: "#D3C6AA"
    shape_globpattern: "#DBBC7F"
    shape_glob_interpolation: "#DBBC7F"
    shape_flag: "#DBBC7F"
    shape_literal: "#A7C080"
    shape_int: "#A7C080"
    shape_float: "#A7C080"
    shape_bool: "#7FBBB3"
    shape_string: "#A7C080"
    shape_raw_string: "#A7C080"
    shape_string_interpolation: "#A7C080"
    shape_datetime: "#DBBC7F"
    shape_range: "#DBBC7F"
    shape_list: "#7FBBB3"
    shape_table: "#7FBBB3"
    shape_record: "#7FBBB3"
    shape_nothing: "#7FBBB3"
    shape_match_pattern: "#A7C080"
    shape_signature: "#D3C6AA"
    shape_block: "#7FBBB3"
    shape_type: "#83C092"
    shape_vardecl: "#D3C6AA"
    shape_variable: "#D3C6AA"
    shape_custom: "#D3C6AA"
})

# ---------------------------------------------------------------------------
# Aliases and directory shortcuts
#
# Fish `alias` + `cd` aliases. The /Users/... paths are macOS-era leftovers
# from the Fish config; they are kept as-is for parity.
# ---------------------------------------------------------------------------
alias tree = eza --tree --level=2
alias ls = eza --icons
alias emacs = emacsclient -c -a nvim

def --env Cws [] { cd '/Users/mattia/Documents/c++_workspace' }
def --env cws [] { cd '/Users/mattia/Documents/c_workspace' }
def --env conf [] { cd ~/.config }
def --env cpp [] { cd '/Users/mattia/Library/Mobile Documents/com~apple~CloudDocs/Workspaces/cpp_workspace/Università' }
def --env javaw [] { cd '/Users/mattia/Library/Mobile Documents/com~apple~CloudDocs/Workspaces/java_workspace' }
def --env latex [] { cd '/Users/mattia/Library/Mobile Documents/com~apple~CloudDocs/Workspaces/latex_workspace' }
def --env js [] { cd '/Users/mattia/Library/Mobile Documents/com~apple~CloudDocs/Workspaces/js' }
def --env py [] { cd '/Users/mattia/Library/Mobile Documents/com~apple~CloudDocs/Workspaces/python_workspace' }

def listvimdir [] {
    print "PLUGGED:/Users/mattia/.local/share/nvim/plugged\nRUNTIME: /opt/homebrew/Cellar/neovim/0.8.0/share/nvim\nCONFIG:/Users/mattia/.config/nvim"
}

# Fish: alias DT='tput clear; printf "\033[3J"; printf "\033[0;0H"'
def --env DT [] {
    ^tput clear
    print -n "\e[3J\e[0;0H"
}

# ---------------------------------------------------------------------------
# Abbreviations
#
# Fish `abbr` -> Reedline abbreviations. They expand when you press space/tab.
# ---------------------------------------------------------------------------
$env.config.abbreviations = {
    gaa: "git add --all"
    gcm: 'git commit -m"'
    mgh: "git clone https://github.com/mattia-marini/"
}

# ---------------------------------------------------------------------------
# Skim integration
#
# Fish used `sk --shell fish | source` plus `skim_key_bindings`. Skim has no
# native Nushell integration, so the widgets are implemented with Nushell
# `commandline` and bound below.
# ---------------------------------------------------------------------------
def --env skim-file [] {
    let query = (commandline | str trim)
    let selected = (
        ^fd --type f --hidden --exclude .git
        | ^sk --height 40% --reverse --query $query
        | str trim
    )
    if ($selected | is-not-empty) {
        commandline edit --insert ($selected | to nuon)
    }
}

def --env skim-dir [] {
    let query = (commandline | str trim)
    let selected = (
        ^fd --type d --hidden --exclude .git
        | ^sk --height 40% --reverse --query $query
        | str trim
    )
    if ($selected | is-not-empty) {
        commandline edit --insert ($selected | to nuon)
    }
}

def --env skim-history [] {
    let selected = (
        history
        | get command
        | uniq
        | reverse
        | ^sk --height 40% --reverse --tac --no-sort
        | str trim
    )
    if ($selected | is-not-empty) {
        commandline edit --replace $selected
    }
}

$env.config.keybindings ++= [
    {
        name: skim_history
        modifier: control
        keycode: char_r
        mode: [emacs vi_normal vi_insert]
        event: { send: executehostcommand, cmd: "skim-history" }
    }
    {
        name: skim_file
        modifier: control
        keycode: char_t
        mode: [emacs vi_normal vi_insert]
        event: { send: executehostcommand, cmd: "skim-file" }
    }
    {
        name: skim_dir
        modifier: alt
        keycode: char_c
        mode: [emacs vi_normal vi_insert]
        event: { send: executehostcommand, cmd: "skim-dir" }
    }
]

# ---------------------------------------------------------------------------
# Kitty integration
#
# Fish bound `space,h/j/k/l` chords. Reedline has no key-chord support, so
# these are mapped to Ctrl+Alt+h/j/k/l instead (requires the Kitty keyboard
# protocol, which Reedline supports in Kitty/WezTerm).
# ---------------------------------------------------------------------------
if ("KITTY_PID" in $env) {
    $env.config.use_kitty_protocol = true
    $env.config.keybindings ++= [
        {
            name: kitty_focus_left
            modifier: control_alt
            keycode: char_h
            mode: [emacs vi_normal vi_insert]
            event: { send: executehostcommand, cmd: "kitten @ focus-window --match=neighbor:left --no-response" }
        }
        {
            name: kitty_focus_right
            modifier: control_alt
            keycode: char_l
            mode: [emacs vi_normal vi_insert]
            event: { send: executehostcommand, cmd: "kitten @ focus-window --match=neighbor:right --no-response" }
        }
        {
            name: kitty_focus_top
            modifier: control_alt
            keycode: char_k
            mode: [emacs vi_normal vi_insert]
            event: { send: executehostcommand, cmd: "kitten @ focus-window --match=neighbor:top --no-response" }
        }
        {
            name: kitty_focus_bottom
            modifier: control_alt
            keycode: char_j
            mode: [emacs vi_normal vi_insert]
            event: { send: executehostcommand, cmd: "kitten @ focus-window --match=neighbor:bottom --no-response" }
        }
    ]
}

# ---------------------------------------------------------------------------
# mise activation
#
# env.nu regenerates ~/.config/nushell/mise.nu before this file is parsed.
# ---------------------------------------------------------------------------
use ($nu.default-config-dir | path join "mise.nu")

# ---------------------------------------------------------------------------
# OrbStack
#
# Fish sourced ~/.orbstack/shell/init2.fish. OrbStack is macOS-only and the
# init file does not exist on this machine, so there is nothing to port.
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
# Custom commands ported from ~/.config/fish/functions/
# ---------------------------------------------------------------------------

# Ported from functions/mvn-new.fish
def mvn-new [arg1?: string, arg2?: string] {
    if $arg1 == null {
        print $"(ansi yellow)(ansi u)Usage:(ansi rst)"
        print $"(ansi yellow)(ansi u)  mvn-new <artifactId>(ansi rst)"
        print $"(ansi yellow)(ansi u)  mvn-new <groupId> <artifactId>(ansi rst)"
        return
    }

    let groupId = if $arg2 == null { "com.mycompany.app" } else { $arg1 }
    let artifactId = if $arg2 == null { $arg1 } else { $arg2 }

    if ($artifactId | path exists) {
        print $"(ansi red)The directory (ansi bo)'($artifactId)'(ansi rst)(ansi red) already exists. Aborting.(ansi rst)"
        return
    }

    print $"(ansi cyan)Creating Maven project (ansi bo)(ansi cyan)($artifactId) (ansi rst)(ansi cyan)...(ansi rst)"

    ^mvn archetype:generate $"-DgroupId=($groupId)" $"-DartifactId=($artifactId)" $"-Dpackage=($groupId)" "-DarchetypeArtifactId=maven-archetype-quickstart" "-DarchetypeVersion=1.5" "-DinteractiveMode=false"

    let project_dir = $artifactId
    let package_dir = ($groupId | str replace --all "." "/")
    let java_dir = $"($project_dir)/src/main/java/($package_dir)"

    # Rename App.java -> Main.java
    mv $"($java_dir)/App.java" $"($java_dir)/Main.java"

    # Replace class name inside the file
    open $"($java_dir)/Main.java"
        | str replace "class App" "class Main"
        | save --force $"($java_dir)/Main.java"

    # Insert exec plugin in pom.xml
    let exec_plugin = ([
        "         <plugin>"
        "           <groupId>org.codehaus.mojo</groupId>"
        "           <artifactId>exec-maven-plugin</artifactId>"
        "           <version>3.5.0</version>"
        "           <configuration>"
        $"             <mainClass>($groupId).Main</mainClass>"
        "           </configuration>"
        "         </plugin>"
    ] | str join "\n")

    print $"(ansi cyan)Adding exec-maven-plugin to pom.xml ...(ansi rst)"

    let pom_file = $"($project_dir)/pom.xml"
    open --raw $pom_file
        | str replace "</plugins>" $"($exec_plugin)\n      </plugins>"
        | save --force $pom_file

    print $"(ansi cyan)Adding .gitignore ...(ansi rst)"

    let gitignore_content = ([
        "# Maven build output"
        "target/"
        "pom.xml.tag"
        "pom.xml.releaseBackup"
        "pom.xml.versionsBackup"
        "release.properties"
        "dependency-reduced-pom.xml"
        "buildNumber.properties"
        ".mvn/timing.properties"
        ""
        "# Eclipse"
        ".project"
        ".classpath"
        ".settings/"
        ""
        "# IntelliJ IDEA"
        ".idea/"
        "*.iml"
        "*.iws"
        "out/"
        ""
        "# VSCode"
        ".vscode/"
        ""
        "# OS files"
        ".DS_Store"
        "Thumbs.db"
        ""
        "# Logs"
        "*.log"
        ""
        "# Temporary files"
        "*.tmp"
    ] | str join "\n")

    $gitignore_content | save --force $"($project_dir)/.gitignore"

    print $"(ansi green)Done! Project created in (ansi bo)(ansi green)./($project_dir)(ansi rst)"
}

# Ported from functions/deploy-repo.fish
def deploy-repo [] {
    let output_dir = "./"
    let output_name = (date now | format date "%d-%m-%y")
    let full_output = $"($output_dir)($output_name)"

    # Java/Maven projects
    let java_dirs = (
        ^find . -type f -name pom.xml
        | lines
        | each {|file| $file | path dirname }
    )
    let java_excludes = (
        $java_dirs
        | each {|dir|
            let rel = ($dir | str replace --regex '^\./' '')
            ["--exclude" $"($rel)/"]
        }
        | flatten
    )

    # Python/uv projects
    let python_dirs = (
        ^find . -type f -name pyproject.toml
        | lines
        | each {|file| $file | path dirname }
    )
    let python_excludes = (
        $python_dirs
        | each {|dir|
            let rel = ($dir | str replace --regex '^\./' '')
            [
                "--exclude" $"($rel)/.venv"
                "--exclude" $"($rel)/__pycache__"
                "--exclude" $"($rel)/.python-version"
                "--exclude" $"($rel)/README.md"
                "--exclude" $"($rel)/pyproject.toml"
                "--exclude" $"($rel)/uv.lock"
            ]
        }
        | flatten
    )

    let base_excludes = [
        "--exclude" "a.out"
        "--exclude" ".DS_Store"
        "--exclude" ".gitignore"
    ]
    let includes = [
        "--include" "files/"
        "--include" "files/***"
        "--include" "main.pdf"
        "--exclude" "*"
    ]

    ^rsync -a ...$base_excludes ...$java_excludes ...$python_excludes ...$includes "./" $full_output

    for excluded_dir in $java_dirs {
        let normalized = ($excluded_dir | str replace --regex '^\./' '')
        let out = $"($full_output)/($normalized)"
        mkdir $"($out)/src"

        let sources = (glob $"($excluded_dir)/src/main/java/com/mycompany/*")
        if ($sources | is-not-empty) {
            ^cp -r ...$sources $"($out)/src"
        }

        let out_excludes = [
            "--exclude" "src"
            "--exclude" ".classpath"
            "--exclude" ".gitignore"
            "--exclude" ".mvn"
            "--exclude" ".project"
            "--exclude" ".settings"
            "--exclude" "pom.xml"
            "--exclude" "target"
        ]

        ^rsync -a ...$out_excludes $"($excluded_dir)/" $out
    }

    print $"(ansi green)Repo deployed to ($full_output)(ansi rst)"
}
