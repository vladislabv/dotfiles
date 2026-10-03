{ pkgs, ... }: {
  languages.rust = {
    enable = true;
    channel = "stable";
  };

  packages = with pkgs; [
    rust-analyzer
    cargo-edit
    cargo-watch
  ];
}
