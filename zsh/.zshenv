export PATH=/opt/homebrew/bin:~/.dotfiles:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:~/Library/Android/sdk/platform-tools:~/Library/Python/3.x/bin:~/usr/local/Caskroom/flutter/2.x.x/flutter/bin/:~/.dotnet/tools:~/imageoptim-cli/dist:/opt/homebrew/Cellar/lua-language-server/2.x.x/libexec/bin/macOS/lua-language-server

export DOTNET_CLI_TELEMETRY_OPTOUT=true

# source .zshenv
alias sz="source ~/.dotfiles/zsh/.zshenv && echo '~/.dotfiles/zsh/.zshenv sourced'"

# brew
alias booba="arch -arm64 brew update && arch -arm64 brew outdated && arch -arm64 brew upgrade --greedy && arch -arm64 brew cleanup"
alias boocka="booba && cocka"
alias bdump="brew bundle dump --describe -f" # create bundle
alias bdinstall="arch -arm64 brew bundle --no-lock" # install from dump

# jino
alias jino="ssh -p 49436 strash@ovz2.strash.pr46m.vps.myjino.ru"

# devd
alias server_slow="devd -A 127.0.0.1 -p 8080 -d 114 -u 51 -n 275 ./ -X"
alias server="devd -A 127.0.0.1 -p 8080 ./ -X"

# png minification
# установка imageoptim-cli
# cd
# curl --output imageoptim-cli.tgz https://registry.npmjs.org/imageoptim-cli/-/imageoptim-cli-3.0.7.tgz
# tar -xvzf ./imageoptim-cli.tgz
# rm imageoptim-cli.tgz
# mv ./package ./imageoptim-cli
# установить https://pngmini.com
# установить https://imageoptim.com
alias png="imageoptim -a -S '**/*.png'"

# npm
alias cocka="npm update -g"

# nvim
alias nvim="arch -arm64 nvim"
