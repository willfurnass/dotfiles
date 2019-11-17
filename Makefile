SHELL := /bin/bash
SYM = ln --symbolic --no-target-directory --no-dereference --force --backup=numbered

all:    bash kanshi mpd spacemacs vim 
.PHONY: bash kanshi mpd spacemacs vim  

bash:
	[[ -d ${HOME}/.bash-git-prompt/.git ]] || git clone https://github.com/magicmonty/bash-git-prompt.git ${HOME}/.bash-git-prompt/ 
	pushd ${HOME}/.bash-git-prompt/ \
	&& git fetch --prune --all \
	&& git merge --ff-only origin/master \
	&& popd
kanshi:
	mkdir -m 700 -p ${HOME}/.config/kanshi
	stow kanshi
mpd:
	stow mpd
spacemacs:
	(pushd ~/.emacs.d >/dev/null && git remote -v | grep -qE "origin\s+https://github.com/syl20bnr/spacemacs\s+\(fetch\)" && popd >/dev/null) || git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
	stow spacemacs
	systemctl --user enable emacs.service
	systemctl --user start emacs.service
ssh-agent:
	#stow ssh-agent
	systemctl --user enable ./ssh-agent/.config/systemd/user/ssh-agent.service
	#systemctl --user daemon-reload
	systemctl --user start ssh-agent.service
