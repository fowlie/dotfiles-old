set -x PATH /usr/local/bin $HOME/.local/bin $PATH
set -x GOPRIVATE "gitlab.tech.dnb.no/*"
set -x PATH $HOME/go/bin $PATH
set -x EDITOR /usr/local/bin/nvim

if status is-interactive
    # Commands to run in interactive sessions can go here

    # Abbreviations
    abbr --add --global -- aws-tail 'cache 3000 aws logs describe-log-groups | jq '\''.logGroups[].logGroupName'\'' -r | fzf | xargs aws logs tail --format short --since 1h'
    abbr --add --global -- aws-tailf 'cache 3000 aws logs describe-log-groups | jq '\''.logGroups[].logGroupName'\'' -r | fzf | xargs aws logs tail --format short --follow --since 1h'
    abbr --add --global -- ciam-docker-login 'aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 364737385840.dkr.ecr.eu-west-1.amazonaws.com'
    abbr --add --global -- ciam-psql 'docker exec -it db-migrate_postgres_1 psql -U postgres ciam'
    abbr --add --global -- cc ciam-curl
    abbr --add --global -- copy 'xclip -o -selection clipboard'
    abbr --add --global -- d docker
    abbr --add --global -- dc docker-compose
    abbr --add --global -- g git
    abbr --add --global -- gap 'git add -p'
    abbr --add --global -- gcm 'git commit -m'
    abbr --add --global -- gd 'git diff'
    abbr --add --global -- gs 'git status'
    abbr --add --global -- gsw 'git switch'
    abbr --add --global -- hms 'home-manager switch'
    abbr --add --global -- lg lazygit
    abbr --add --global -- zj zellij
    abbr --add --global -- zjc zellij 'zellij --layout compact'

    # Aliases
    alias ... 'cd ../..'
    alias .... 'cd ../../..'
    alias ls 'exa --icons --oneline --group-directories-first'
    alias ll 'exa --icons --long --group-directories-first --time-style long-iso'

    # https://news.ycombinator.com/item?id=11071754
    alias config '/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

    # https://github.com/jorgelbg/pinentry-touchid
    alias pinentry pinentry-mac

    # Unleash the starship
    starship init fish | source
end
