# Dotfiles

Raw dotfile sources managed separately from the NixOS configuration.

Linked into place by [home-manager](https://github.com/nix-community/home-manager) using the [mutable/immutable pattern](https://gvolpe.com/blog/home-manager-dotfiles-management/).

## Structure

```
dotfiles/
├── fish/
│   ├── config.fish               # Fish shell entrypoint (PATH, env, integrations)
│   ├── fish_plugins              # Fisher plugin list (fisher install reads this)
│   └── conf.d/
│       ├── abbreviations.fish    # Shell abbreviations (git, nix, podman, devenv)
│       └── env.fish              # Environment variables (GOPATH, CARGO_HOME, etc.)
├── helix/
│   ├── config.toml               # Helix editor settings (theme, keybindings, statusline)
│   └── languages.toml            # Language-specific settings (formatters, LSP)
├── wezterm/
│   └── .wezterm.lua              # WezTerm config (runs on Windows, synced from WSL)
├── git/
│   └── .gitconfig                # Git config (user, aliases, delta pager)
├── starship/
│   └── starship.toml             # Starship prompt settings
├── devenv-templates/
│   ├── python/devenv.nix         # uv + ruff + pyright
│   ├── go/devenv.nix             # gopls + delve + go-tools
│   ├── rust/devenv.nix           # rust-analyzer + cargo-edit + cargo-watch
│   └── web/devenv.nix            # node + pnpm + ts-language-server + tailwind
└── scripts/
    └── dev-init                  # Bootstrap a new devenv project
```

## How it's used

The NixOS config repo ([nixos-wsl](https://github.com/vstasenko/nixos-wsl)) symlinks these files into place via home-manager:

| Dotfile | Symlink target |
|---|---|
| `fish/` | `~/.config/fish/` |
| `helix/` | `~/.config/helix/` |
| `starship/starship.toml` | `~/.config/starship.toml` |
| `git/.gitconfig` | `~/.gitconfig` |
| `wezterm/.wezterm.lua` | `/mnt/c/Users/<user>/.wezterm.lua` (Windows side) |
| `scripts/dev-init` | `~/.local/bin/dev-init` |

### Mutable mode (default)

Files are symlinked directly to this working copy. Edit any file, changes apply instantly — no rebuild needed:

```bash
git pull                          # get latest changes
# edit fish/config.fish           # changes are live
```

### Immutable mode

Files are copied into the nix store from a pinned git commit. Requires rebuild on change:

```bash
# In nixos-wsl repo:
nix flake update dotfiles
sudo nixos-rebuild switch --flake .#wsl
```

## Fish plugins

Plugins are managed by [fisher](https://github.com/jorgebucaran/fisher). The plugin list lives in `fish/fish_plugins`.

**Bootstrap (one-time):**
```bash
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
fisher install
```

**Add a plugin:**
```bash
fisher install <author>/<plugin>
```

Fisher writes directly into `~/.config/fish/`, which is symlinked to this repo. Commit the changes:

```bash
git add fish_plugins fish/functions/
git commit -m "Add <plugin>"
```

## WezTerm

WezTerm runs on Windows, not inside WSL. The `.wezterm.lua` config is copied to the Windows user profile on every `nixos-rebuild` by a home-manager activation script.

Ensure `default_domain` in `.wezterm.lua` matches your WSL distro name:
```bash
wsl -l -v    # run in Windows PowerShell
```

## Dev-init script

Bootstrap a new devenv project with an optional language template:

```bash
dev-init my-project              # empty shell
dev-init my-api python           # uv + ruff + pyright
dev-init my-cli go               # gopls + delve
dev-init my-app rust             # rust-analyzer + cargo-edit + cargo-watch
dev-init my-site web             # node + pnpm + ts-language-server + tailwind
```

Creates `devenv.nix` and `.envrc` from the template, then runs `direnv allow`.

### Templates

| Template | What's included |
|---|---|
| `python` | `languages.python` + `uv`, `ruff`, `pyright` |
| `go` | `languages.go`, `gopls`, `go-tools`, `delve` |
| `rust` | `languages.rust` (stable), `rust-analyzer`, `cargo-edit`, `cargo-watch` |
| `web` | `languages.javascript` + `pnpm`, `ts-language-server`, `tailwindcss-language-server`, `prettier`, `eslint_d` |
| _(none)_ | Empty shell with no packages |

### Python + FastAPI

After `dev-init my-api python`:

```bash
cd my-api
uv init
uv add "fastapi[standard]"
uv add --dev pytest
uvx library-skills         # install AI agent skills for FastAPI (by tiangolo)
devenv up
```

### Adding a new template

1. Create `devenv-templates/<name>/devenv.nix` in this repo
2. Add the template name to the `dev-init` script help text
3. `git push` and `git pull` on the machine
