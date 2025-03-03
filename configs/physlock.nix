{
  pkgs,
  config,
  libs,
  ...
}:
let
  lock = pkgs.writeScript "lock" ''
    exec sudo systemctl start physlock
  '';
in
{
  services.physlock = {
    enable = true;
    disableSysRq = false;
    muteKernelMessages = true;
    lockOn = {
      suspend = true;
      hibernate = true;
    };
  };

  services.xserver.xautolock = {
    enable = true;
    locker = "${lock}";
    time = 10;
  };
}
