function fish_prompt
	set -g __fish_git_prompt_use_informative_chars true
	set -g __fish_git_prompt_showcolorhints true
	set -g __fish_git_prompt_showupstream auto
	set -g __fish_git_prompt_showuntrackedfiles true
	set -g __fish_git_prompt_showstashstate true
	set -g __fish_git_prompt_showdirtystate true
	printf "%s" (set_color --bold white) strash (set_color normal) (set_color white) '  ' (prompt_pwd) (fish_vcs_prompt) ' ' (set_color normal)
end
