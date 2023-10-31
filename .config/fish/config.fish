set -x PATH /usr/local/bin $HOME/.local/bin $PATH
set -x GOPRIVATE "gitlab.tech.dnb.no/*"
set -x DOCKER_HOST "unix://$HOME/.colima/default/docker.sock"
set -x PATH $HOME/go/bin $PATH
set -x PATH /opt/homebrew/bin $PATH
set -x EDITOR /opt/homebrew/bin/nvim
set -x AWS_PROFILE dev
set -x AWS_REGION eu-north-1

# used for syntax highlighting in lf previews
# see https://xyproto.github.io/splash/docs/all.html
set -x PISTOL_CHROMA_STYLE github-dark

if status is-interactive
    # Commands to run in interactive sessions can go here

    # Abbreviations
    abbr --add --global -- ciam-docker-login 'aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 364737385840.dkr.ecr.eu-west-1.amazonaws.com'
    abbr --add --global -- ciam-psql 'docker exec -it db-migrate_postgres_1 psql -U postgres ciam'
    abbr --add --global -- cc ciam-curl
    abbr --add --global -- copy 'xclip -o -selection clipboard'
    abbr --add --global -- d docker
    abbr --add --global -- dc docker-compose

    # Git abbreviations
    abbr --add --global -- g git
    abbr --add --global -- gap 'git add -p'
    abbr --add --global -- gcm 'git commit -m'
    abbr --add --global -- gd 'git diff'
    abbr --add --global -- gs 'git status'
    abbr --add --global -- gsw 'git switch'
    abbr --add --global -- lg lazygit

    # AWS abbreviations
    abbr --add --global -- aws-tail 'aws logs describe-log-groups | jq '\''.logGroups[].logGroupName'\'' -r | fzf | xargs aws logs tail --format short --since 1h'
    abbr --add --global -- aws-tailf 'aws logs describe-log-groups | jq '\''.logGroups[].logGroupName'\'' -r | fzf | xargs aws logs tail --format short --follow --since 1h'
    abbr --add --global -- ap aws-switch-profile
    abbr --add --global -- ar aws-switch-region
    abbr --add --global -- al 'aws sso login'

    # Aliases
    alias ... 'cd ../..'
    alias .... 'cd ../../..'
    alias aws-switch-profile 'set -x AWS_PROFILE (cat ~/.aws/config | grep "\[" | grep -v default | tr -d "[]" | awk "{print \$2}" | fzf --header "AWS Profiles" --height 6 --reverse --bind one:accept)'
    alias aws-switch-region 'set -x AWS_REGION (echo -e "eu-north-1\neu-west-1" | fzf --header "AWS Regions" --height 6 --reverse --bind one:accept)'
    alias ls 'exa --icons --oneline --group-directories-first'
    alias ll 'exa --all --icons --long --group-directories-first --time-style long-iso'

    # https://news.ycombinator.com/item?id=11071754
    alias config '/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

    # https://github.com/jorgelbg/pinentry-touchid
    alias pinentry pinentry-mac

    # Bindings
    bind \co 'set old_tty (stty -g); stty sane; lfcd; stty $old_tty; commandline -f repaint'

    # Unleash the starship
    starship init fish | source
end
