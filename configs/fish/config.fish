if status is-interactive
    alias v='nvim .'
    alias h='hx .'
    # quickly enters nvim in the context of the config
    alias c='fish -c "cd ~/nixos-config; nvim ."'

    abbr dup 'docker compose up --build'
    abbr ddown 'docker compose down'
    abbr duw 'docker compose watch --no-up & docker compose up --build'
    abbr d docker

    # makes nixos-rebuild use the custom configuration
    # abbr nrs "sudo nixos-rebuild switch --flake /home/mark/nixos-config#mark"
    # abbr nrt "sudo nixos-rebuild test --flake /home/mark/nixos-config#mark"
    abbr ns "nh os switch /home/mark/nixos-config -H mark"
    abbr nu "nh os switch /home/mark/nixos-config -H mark -u"
    abbr nt "nh os test /home/mark/nixos-config -H mark"

    abbr sr "sudo reboot now"
    abbr sn "sudo shutdown now"
    abbr g git

    # VIS kubectl commands
    abbr kb kubectl
    abbr kbs "kubectl -n vis-cat-staging"
    abbr kbp "kubectl -n vis-cat-prod"

    abbr yd "yarn dev"
    abbr yi yarn
    abbr nd "npm run dev"
    abbr ni "npm i"

    abbr fuck-infoscreen1 "ssh infoscreen-1.vis.ethz.ch 'sudo systemctl restart getty@tty1.service'"
    abbr fuck-infoscreen2 "ssh infoscreen-2.vis.ethz.ch 'sudo systemctl restart getty@tty1.service'"
    abbr gyolo "git commit --amend --no-edit --all && git push --force-with-lease"

    # removes fish greeting
    set fish_greeting

    atuin init fish --disable-up-arrow | source

    starship init fish | source

    kubectl completion fish | source
    sipctl completion fish | source

    set -gx PATH $PATH $HOME/.krew/bin

    set -gx EDITOR nvim

    # makes fzf ignore files located in .grepignore
    fzf --fish | source
    set -gx FZF_ALT_C_COMMAND 'fd --type d'

    function to64 -d "Encode to base64"
        echo -n $argv | base64
    end

    function flakeinit -d "Init flake template"
        nix flake init --template github:the-nix-way/dev-templates#$argv
    end
    abbr fi flakeinit

    function shell -d "Nix Shell"
        nix shell nixpkgs#$argv
    end

    function tmp -d "Create a temp file and open it in vim"
        set tmpfile (mktemp /tmp/tmp.XXXXXXX.$argv)
        vim $tmpfile
        set_color green
        echo $tmpfile
    end

    # quickly creates a basic shell.nix and .envrc in the local directory
    alias s='echo "\
with import <unstable> {};
with pkgs;
mkShell {
  buildInputs = [];
}" > shell.nix && echo "use nix" > .envrc'

    function p -d "Create and build patched nix binary"
        if test -z $argv[1]
            echo "Usage: p <executable>"
            return 1
        end
        echo "# Generated with Fish
{ stdenv, autoPatchelfHook }:
stdenv.mkDerivation {
  name = \"exe\";
  version = "0";
  src = $argv;
  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;
  nativeBuildInputs = [autoPatchelfHook];
  installPhase = \"install -Dm755 \$src \$out/bin/exe\";
}" >build.nix
        nix-build -E "with import <unstable> {}; callPackage ./build.nix {}"

    end

end
