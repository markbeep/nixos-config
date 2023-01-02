{
  services.dunst.enable = true;
  services.dunst.settings = {
    global = {
      frame_width = 1;
      frame_color = "#888888";
      font = "Noto Sans 8";
      markup = true;
      format = "%s %p\n%b";
      sort = true;
      indicate_hidden = true;
      alignment = "left";
      bounce_freq = 5;
      show_age_threshold = 60;
      word_wrap = false;
      ignore_newline = false;
      geometry = "0x4-25+25";
      shrink = true;
      idle_threshold = 120;
      monitor = 0;
      follow = "mouse";
      sticky_history = false;
      history_length = 20;
      show_indicators = true;
      line_height = 0;
      separator_height = 1;
      padding = 8;
      horizontal_padding = 10;
      browser = "firefox";
      icon_position = "left";
      max_icon_size = 64;
      width = 200;
    };

    shortcuts = {
      close = "mod1+space"; # alt + space
      close_all = "ctrl+mod1+space"; # ctrl + alt + space
      history = "ctrl+mod4+h"; # ctrl + super + h
      context = "ctrl+mod1+c"; # ctrl + alt + c 
    };

    urgency_low = {
      background = "#333333";
      foreground = "#888888";
      timeout = 5;
    };

    urgency_normal = {
      background = "#333333";
      foreground = "#aaaaaa";
      timeout = 5;
    };

    urgency_critical = {
      background = "#D62929";
      foreground = "#F9FAF9";
      timeout = 0;
    };

    experimental = {
      per_monitor_dpi = true;
    };
  };
}
