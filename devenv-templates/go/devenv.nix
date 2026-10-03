{ pkgs, ... }: {
  languages.go = {
    enable = true;
  };

  packages = with pkgs; [
    gopls
    go-tools
    delve
  ];
}
