abbr -a ls eza
abbr -a ll 'eza -la'
abbr -a lt 'eza --tree --level=2'
abbr -a cat bat
abbr -a find fd
abbr -a grep rg
abbr -a .. 'cd ..'
abbr -a ... 'cd ../..'
abbr -a .... 'cd ../../..'

abbr -a g git
abbr -a gs 'git status'
abbr -a gd 'git diff'
abbr -a ga 'git add'
abbr -a gc 'git commit'
abbr -a gp 'git push'
abbr -a gl 'git log --oneline'
abbr -a gco 'git checkout'
abbr -a gb 'git branch'

abbr -a rebuild 'sudo nixos-rebuild switch --flake .#wsl'
abbr -a update 'nix flake update --flake .'
abbr -a gc 'sudo nix-collect-garbage -d'
abbr -a nx 'nix run nixpkgs#'
abbr -a nxs 'nix shell nixpkgs#'

abbr -a v hx
abbr -a vim hx
abbr -a vi hx

abbr -a p podman
abbr -a ps 'podman ps'
abbr -a pi 'podman images'
abbr -a pr 'podman run -it'
abbr -a pe 'podman exec -it'

abbr -a dev 'devenv shell'
abbr -a devup 'devenv up'
abbr -a devt 'devenv test'
