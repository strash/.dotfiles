if status is-interactive
    # Commands to run in interactive sessions can go here
end
abbr -a -- l 'ls -lahG'
abbr -a -- go_clean 'go clean -x -cache -modcache'
abbr -a -- boocka 'bun update -g && npm update -g && arch -arm64 brew update && arch -arm64 brew outdated && arch -arm64 brew upgrade --greedy && brew cleanup -s && brew autoremove'
abbr -a -- firebase_update 'curl -sL https://firebase.tools | upgrade=true bash'
abbr -a -- bdump 'brew bundle dump --describe -f'
abbr -a -- bdinstall 'arch -arm64 brew bundle --no-lock'
abbr -a -- bree 'arch -arm64 brew install'

starship init fish | source
