SHELL := /bin/bash
SYM = ln --symbolic --no-target-directory --no-dereference --force --backup=numbered

all:    bash kanshi mpd spacemacs vim weechat
.PHONY: bash kanshi mpd spacemacs vim weechat 

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
vim:
	mkdir -p ~/.venvs
	test -f ~/.venvs/neovim3/bin/python || python3 -m venv ~/.venvs/neovim3
	~/.venvs/neovim3/bin/python -m pip freeze | grep -q neovim || ~/.venvs/neovim3/bin/python -m pip install neovim
	$(SYM) `pwd`/vimrc ${HOME}/.vimrc
	mkdir -p ${HOME}/.vim
	$(SYM) `pwd`/vim-ftplugin ${HOME}/.vim/ftplugin
	$(SYM) `pwd`/vim-syntax ${HOME}/.vim/syntax
	$(SYM) `pwd`/vim-after ${HOME}/.vim/after
	$(SYM) `pwd`/vim-autoload ${HOME}/.vim/autoload
	mkdir -p ${HOME}/.config
	$(SYM) ${HOME}/.vim ${HOME}/.config/nvim
	$(SYM) ${HOME}/.vimrc ${HOME}/.config/nvim/init.vim
weechat:
	stow weechat
xrandr:
	mkdir -p ${HOME}/bin
	stow xrandr
