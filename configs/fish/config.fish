if status is-interactive
    # alias for nvim
    alias v='nvim .'
    # quickly enters nvim in the context of the config
    alias c='fish -c "cd ~/nixos-config; nvim ."'
    
    alias dup='docker compose up --build'
    alias ddown='docker compose down'
    
    # makes nixos-rebuild use the custom configuration
    alias nrs="sudo nixos-rebuild switch --flake /home/mark/nixos-config#mark"

    # removes fish greeting
    set fish_greeting
    
    kubectl completion fish | source
    sipctl completion fish | source 

    set -gx PATH $PATH $HOME/.krew/bin

    # makes fzf ignore files located in .grepignore
    set -gx FZF_ALT_C_COMMAND 'fd --type d'

    set -gx EDITOR 'nvim'

end

