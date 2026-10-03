{ pkgs, ... }: {
  languages.javascript = {
    enable = true;
    pnpm.enable = true;
  };

  packages = with pkgs; [
    nodePackages.ts-language-server
    tailwindcss-language-server
    prettier
    eslint_d
  ];
}
