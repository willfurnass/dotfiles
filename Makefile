SHELL := /bin/bash
SYM = ln --symbolic --no-target-directory --no-dereference --force --backup=numbered

all: abcde ack bash beets csi git i3 i3status irssi jupyter-css matplotlib mimeapps mpd mutt rprofile todotxt tmux vim weechat xinitrc 

abcde:
	 stow abcde
ack:
	 stow ack
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
git:
	stow git
gpg-agent:
	stow gpg-agent
i3: 
	stow i3
i3status: 
	stow i3status
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
mutt:
	mkdir -m 700 -p ${HOME}/.mutt/cache/persgm/headers
	mkdir -m 700 -p ${HOME}/.mutt/cache/persgm/bodies
	mkdir -m 700 -p ${HOME}/.mutt/cache/workgm/headers
	mkdir -m 700 -p ${HOME}/.mutt/cache/workgm/bodies
	stow mutt
	stow extract_url
newsboat:
	mkdir -m 700 -p ${HOME}/.config
	stow newsboat
R:
	stow R
ranger:
	mkdir -m 0700 -p ${HOME}/.config/ranger
	stow ranger
ssh-agent:
	#stow ssh-agent
	systemctl --user enable ./ssh-agent/.config/systemd/user/ssh-agent.service
	#systemctl --user daemon-reload
	systemctl --user start ssh-agent.service
todotxt:
	stow todotxt
tmux:
	stow tmux
	[ -d ~/.tmux/plugins/tpm ] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	pushd ~/.tmux/plugins/tpm \
	    && git fetch --prune --all \
	    && git merge --ff-only origin/master \
	    && popd
	${HOME}/.tmux/plugins/tpm/bin/install_plugins
	${HOME}/.tmux/plugins/tpm/bin/update_plugins all
vim:
	$(SYM) `pwd`/vimrc ${HOME}/.vimrc
	mkdir -p ${HOME}/.vim
	$(SYM) `pwd`/vim-ftplugin ${HOME}/.vim/ftplugin
	$(SYM) `pwd`/vim-syntax ${HOME}/.vim/syntax
	$(SYM) `pwd`/vim-after ${HOME}/.vim/after
	$(SYM) `pwd`/vim-autoload ${HOME}/.vim/autoload
	mkdir -p ${HOME}/.config
	$(SYM) ${HOME}/.vim ${HOME}/.config/nvim
	$(SYM) ${HOME}/.vimrc ${HOME}/.config/nvim/init.vim
	type -f pip |> /dev/null && pip list --user | grep -q neovim || pip install --user neovim
weechat:
	stow weechat
xinitrc:
	stow xinitrc
Xresources:
	mkdir ${HOME}/.Xresources.d
	stow Xresources


# TO ADD:
#bashrc
#50-synaptics.conf
#99-nozap.conf
#lyx_user.bind
