SHELL := /bin/bash
SYM = ln --symbolic --no-target-directory --no-dereference --force --backup=numbered

all: abcde bash beets csi emacs git i3 irssi jupyter-css matplotlib mimeapps mksh mpd rprofile tmux vi vim weechat xinitrc

abcde:
	 stow abcde
bash:
	[[ -d ${HOME}/.bash-git-prompt/ ]] || git clone https://github.com/magicmonty/bash-git-prompt.git ${HOME}/.bash-git-prompt/ 
	pushd ${HOME}/.bash-git-prompt/ \
	    && git fetch --prune --all \
	    && git merge --ff-only origin/master \
	    && popd
beets:
	stow beets
csi:
	stow csi
docker:
	make -p -m 700 ${HOME}/.docker
	stow docker
emacs:
	make -p -m 700 ${HOME}/.emacs.d
	stow emacs
git:
	stow git
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
	[ -d ~/.tmux/plugins/tpm ] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	pushd ~/.tmux/plugins/tpm \
	    && git fetch --prune --all \
	    && git merge --ff-only origin/master \
	    && popd
	${HOME}/.tmux/plugins/tpm/bin/install_plugins
	${HOME}/.tmux/plugins/tpm/bin/update_plugins all
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
weechat:
	stow weechat
xinitrc:
	stow xinitrc
xrandr:
	mkdir -p ${HOME}/bin
	stow xrandr
Xresources:
	mkdir -p ${HOME}/.Xresources.d
	stow Xresources
	ln -s ~/.Xresources ~/.Xdefaults
zathura:
	mkdir -p ${HOME}/.config/
	$(SYM) `pwd`/zathura ${HOME}/.config/zathura
