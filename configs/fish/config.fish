if status is-interactive
    alias v='nvim .'
    alias h='hx .'
    # quickly enters nvim in the context of the config
    alias c='fish -c "cd ~/nixos-config; hx ."'
    
    abbr dup 'docker compose up --build'
    abbr ddown 'docker compose down'
    abbr duw 'docker compose watch --no-up & docker compose up --build'
    abbr d 'docker'
    
    # makes nixos-rebuild use the custom configuration
    abbr nrs "sudo nixos-rebuild switch --flake /home/mark/nixos-config#mark"
    abbr nrt "sudo nixos-rebuild test --flake /home/mark/nixos-config#mark"

    abbr sr "sudo reboot now"
    abbr sn "sudo shutdown now"
    abbr g "git"

    # VIS kubectl commands
    abbr kb "kubectl"
    abbr kbs "kubectl -n vis-cat-staging"
    abbr kbp "kubectl -n vis-cat-prod"

    abbr yd "yarn dev"
    abbr yi "yarn"
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

    # makes fzf ignore files located in .grepignore
    set -gx FZF_ALT_C_COMMAND 'fd --type d'

    set -gx EDITOR 'hx'

    # quickly creates a basic shell.nix and .envrc in the local directory
    alias s='echo "\
with import <unstable> {};
with pkgs;
mkShell {
  buildInputs = [];
}" > shell.nix && echo "use nix" > .envrc'

function to64 -d "Encode to base64"
    echo -n $argv | base64
end

end

