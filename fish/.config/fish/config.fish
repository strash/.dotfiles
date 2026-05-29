if status is-interactive
    # Commands to run in interactive sessions can go here
end
abbr -a -- go_clean 'go clean -x -cache -modcache'
abbr -a -- boocka 'brew update && brew outdated && brew upgrade --greedy && brew cleanup -s && brew autoremove && bun update -g'
abbr -a -- firebase_update 'curl -sL https://firebase.tools | upgrade=true bash'
abbr -a -- bdump 'brew bundle dump --describe -f'
abbr -a -- bdinstall 'brew bundle --no-lock'
abbr -a -- reload 'source $HOME/.config/fish/config.fish'

starship init fish | source

# Mole shell completion
set -l output (mole completion fish 2>/dev/null); and echo "$output" | source
