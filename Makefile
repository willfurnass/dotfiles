SHELL := /bin/bash
SYM = ln --symbolic --no-target-directory --no-dereference --force --backup=numbered

all:    bash beets i3 irssi jupyter-css kanshi lyx matplotlib mimeapps mksh mpd rprofile spacemacs tmux vi vim weechat xinitrc
.PHONY: bash beets i3 irssi jupyter-css kanshi lyx matplotlib mimeapps mksh mpd rprofile spacemacs tmux vi vim weechat xinitrc

bash:
	[[ -d ${HOME}/.bash-git-prompt/.git ]] || git clone https://github.com/magicmonty/bash-git-prompt.git ${HOME}/.bash-git-prompt/ 
	pushd ${HOME}/.bash-git-prompt/ \
	&& git fetch --prune --all \
	&& git merge --ff-only origin/master \
	&& popd
beets:
	stow beets
docker:
	mkdir -p -m 700 ${HOME}/.docker
	stow docker
gnupg:
	mkdir -p -m 700 ${HOME}/.gnupg
	stow gnupg
i3: 
	# Install i3, dunst and i3status config
	stow i3
inputrc:
	stow inputrc
irssi:
	mkdir -m 700 -p ${HOME}/.irssi/certs
	find `pwd`/irssi/config -type f -exec chmod 600 {} \;
	find `pwd`/irssi/config -type d -exec chmod 700 {} \;
	$(SYM) `pwd`/irssi/config ${HOME}/.irssi/config
	$(SYM) `pwd`/irssi/default.theme ${HOME}/.irssi/default.theme
jupyter-css:
	stow jupyter-css
kanshi:
	mkdir -m 700 -p ${HOME}/.config/kanshi
	stow kanshi
lyx:
	mkdir -p -m 0700 ~/.lyx/bind
	stow lyx
matplotlib:
	stow matplotlib
mimeapps:
	stow mimeapps
mksh:
	stow mksh
mpd:
	stow mpd
newsboat:
	mkdir -m 700 -p ${HOME}/.config
	stow newsboat
rprofile:
	stow R
ranger:
	mkdir -m 0700 -p ${HOME}/.config/ranger
	stow ranger
rofi:
	mkdir -m 0700 -p ${HOME}/.config/rofi
	stow rofi
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
sway: Xresources rofi
	# Install sway config
	mkdir -p ~/.config/sway
	stow sway
tmux:
	stow tmux
vi:
	stow vi
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
vscode: 
	stow vscode
weechat:
	stow weechat
xinitrc:
	stow xinitrc
xrandr:
	mkdir -p ${HOME}/bin
	stow xrandr
