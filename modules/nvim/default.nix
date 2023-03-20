{ pkgs, ... }: {
  # home.file.".config/nvim/init.vim".source = ./init.vim;
  home.file.".config/nvim/coc-settings.json".source = ./coc-settings.json;

  programs = {
    neovim = {
      enable = true;
      withPython3 = true;
      plugins = with pkgs.vimPlugins; [ packer-nvim ];
      extraPackages = with pkgs; [
        (python3.withPackages (ps: with ps; [
          black
          flake8
        ]))
      ];
      extraPython3Packages = (ps: with ps; [
        jedi
      ]);
    };
  };
}
