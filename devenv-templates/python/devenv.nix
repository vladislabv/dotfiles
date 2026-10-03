{ pkgs, ... }: {
  languages.python = {
    enable = true;
    uv.enable = true;
  };

  packages = with pkgs; [
    ruff
    pyright
  ];
}
