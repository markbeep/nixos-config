pkgs: with pkgs; [
  # kubernetes / VIS
  kubectl
  krew # package manager for kubectl
  (pkgs.libsForQt5.callPackage ./derivations/sipctl/default.nix { })
  (pkgs.libsForQt5.callPackage ./derivations/servis/default.nix { })
  # only attempts to install if ssh keys are setup. Installs hello otherwise
  (if builtins.pathExists /root/.ssh then
    (pkgs.libsForQt5.callPackage ./derivations/visdev/default.nix { })
  else
    hello)
]
