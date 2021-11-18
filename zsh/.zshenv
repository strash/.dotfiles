export PATH=~/.dotfiles:~/Library/Android/sdk/platform-tools:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:~/nvim-osx64/bin:~/Library/Python/3.x/bin:~/lua-5.x.x/src:~/usr/local/Caskroom/flutter/2.x.x/flutter/bin/:/opt/homebrew/bin:/Users/strash/.dotnet/tools:~/imageoptim-cli/dist

export DOTNET_CLI_TELEMETRY_OPTOUT=true

# source .zshenv
alias sz="source ~/.dotfiles/zsh/.zshenv && echo '~/.dotfiles/zsh/.zshenv reloaded'"

# brew
alias booba="arch -arm64 brew update && arch -arm64 brew outdated && arch -arm64 brew upgrade --greedy && arch -arm64 brew cleanup"
alias boocka="booba && cocka"
alias bdump="brew bundle dump --describe -f"

# jino
alias jino="ssh -p 49436 strash@ovz2.strash.pr46m.vps.myjino.ru"

# che stage
alias che="ssh deploy@167.86.105.20"
export CHE=deploy@167.86.105.20:/home/deploy/chvsk-front/build/godot

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
