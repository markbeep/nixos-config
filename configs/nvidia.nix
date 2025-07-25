# UNUSED AS OF 21.07.2025. Using nixos-hardware repo instead

{
  pkgs,
  config,
  libs,
  ...
}:

{

  # Enable OpenGL
  hardware.graphics.enable = true;

  # Load nvidia driver for Xorg and Wayland
  # Adding "modesetting" makes the system work, but the GPU is not actually used
  services.xserver.videoDrivers = [
    # "modesetting"
    "nvidia"
  ];

  hardware.nvidia = {

    # modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Not compatible with huawei matebook 2019
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    prime = {
      # Test with glxgears + nvidia-smi/nvitop if the GPU is actually being used
      # sync.enable = true; # Makes the GPU always get used

      # enabled temporarily to test glxgears with `nvidia-offload glxgears`
      reverseSync.enable = true;
      offload = {
        enableOffloadCmd = true;
      };

      # Bus ID values for the integrated GPU (CPU) and the actual GPU
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };

    # use the driver version from https://www.nvidia.com/en-us/drivers/
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "570.172.08";
      sha256_64bit = "sha256-N/1Ra8Teq93U3T898ImAT2DceHjDHZL1DuriJeTYEa4=";
      openSha256 = "sha256-N/1Ra8Teq93U3T898ImAT2DceHjDHZL1DuriJeTYEa4=";
      settingsSha256 = "sha256-N/1Ra8Teq93U3T898ImAT2DceHjDHZL1DuriJeTYEb4=";
      persistencedSha256 = "sha256-AlaGfggsr5PXsl+nyOabMWBiqcbHLG4ij617I4xvoX0=";
    };

  };

}
