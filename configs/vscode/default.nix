{ pkgs, ... }: {
  programs.vscode = {
    enable = false;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-python.python
    ];
  };
}
