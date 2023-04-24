pkgs: unstable: with pkgs; [
  # languages
  nodejs-16_x
  yarn
  go_1_18
  hugo
  gnumake
  gcc

  # LSP tools
  nil # nix lsp
  statix
  nixpkgs-fmt

  # latex
  texlive.combined.scheme-full

  git-lfs
]
