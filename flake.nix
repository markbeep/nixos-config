{
  description = "A very basic flake";
  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem [ "aarch64-darwin" "x86_64-darwin" "x86_64-linux" ] (system:
      let pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell { packages = [ pkgs.cowsay ]; };
      });

}
