{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "markbeep";
    userEmail = "mrkswrn@gmail.com";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
      a = "add .";
    };
  };
}
