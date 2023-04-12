{ pkgs, ... }: {
  programs.vscode = {
    enable = false;
    extensions = with pkgs.vscode-extensions; [
      ms-python.python
    ];
  };
}
