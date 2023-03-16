{lib, ...}:
let
  # gets the specific index from the pywal colors
  getColor = x: with lib; pipe ~/.cache/wal/colors [
    readFile
    (splitString "\n")
    (lists.sublist x (add x 1))
    lists.head
  ];
  colorFG = getColor 7;
  colorBG = getColor 0;
in
{
  services.dunst.enable = true;
  services.dunst.settings = {
    global = {
      # display
      monitor = 0;
      # geometry
      width = 200;
      height = 300;
      origin = "top-right";
      offset = "10x30";
      scale = 0;
      notification_limit = 0;
      corner_radius = 5;

      transparency = 15;
      separator_height = 1;
      padding = 8;
      horizontal_padding = 10;
      text_icon_padding = 0;
      separator_color = "frame";
      sort = true;
      idle_threshold = 120;
      frame_width = 0;

      # text
      font = "Monospace 8"; # or Noto Sans
      line_height = 0;
      markup = "full";
      alignment = "left";
      vertical_alignment = "center";
      ellipsize = "middle";
      ignore_newline = false;
    };

    shortcuts = {
      close = "mod1+space"; # alt + space
      close_all = "ctrl+mod1+space"; # ctrl + alt + space
      history = "ctrl+mod4+h"; # ctrl + super + h
      context = "ctrl+mod1+c"; # ctrl + alt + c 
    };

    urgency_low = {
      background = colorBG;
      foreground = colorFG;
      timeout = 5;
    };

    urgency_normal = {
      background = colorBG;
      foreground = colorFG;
      frame_width = 1;
    };

    urgency_critical = {
      background = "#ff5555";
      foreground = "#f8f8f2";
      frame_color = "#ff5555";
      timeout = 0;
    };

    experimental = {
      per_monitor_dpi = true;
    };
  };
}
