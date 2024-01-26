{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      zig.format = "via [$symbol($version )]($style)";
      zig.version_format = "\${major}.\${minor}";

      nix_shell = {
        format = "via [$symbol]($style)";
        symbol = "❄️ ";
      };
    };
  };
}
