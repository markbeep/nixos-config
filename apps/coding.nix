pkgs: unstable: with pkgs; [
  git-crypt

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
  java-language-server
  maven # required for java-language-server

  # latex
  texlive.combined.scheme-full

  git-lfs
]
