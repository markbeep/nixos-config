if status is-interactive
    # alias for nvim
    alias vim='nvim'
    alias vi='nvim'
    alias v='nvim .'
    
    # ssh shortcuts
    alias ssh-home='ssh mark@server.markc.su'
    alias ssh-pi='ssh -t mark@server.markc.su ssh pi@192.168.1.101'
    alias ssh-vsos='ssh debian@mcsurgay.vsos.ethz.ch'
    
    alias dup='docker compose up --build'
    alias ddown='docker compose down'
    
    alias hms="home-manager switch"

    # removes fish greeting
    set fish_greeting
    
    kubectl completion fish | source
    sipctl completion fish | source 

    set -gx PATH $PATH $HOME/.krew/bin

    # makes fzf ignore files located in .grepignore
    set -gx FZF_ALT_C_COMMAND 'rg --hidden --files --sort-files --ignore-file=$HOME/nixos-config/modules/fish/.ignore --null | xargs -0 dirname | uniq'

end

