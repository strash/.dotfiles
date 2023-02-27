function cocka
	pnpm update -g
end

function booba
	arch -arm64 brew update && arch -arm64 brew outdated && arch -arm64 brew upgrade --greedy && brew cleanup -s
end

function boocka
	booba && cocka
end
