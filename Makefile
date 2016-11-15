SHELL := /bin/bash
SYM = ln --symbolic --no-target-directory --no-dereference --force --backup=numbered

all: inst-abcde inst-ackrc inst-bash inst-beets inst-csirc inst-gitconfig inst-jupyter-css inst-matplotlibrc inst-mpd inst-rprofile inst-todotxt inst-tmux inst-vim inst-weechat inst-xinitrc 
#inst-marblemouse 

inst-abcde:
	 $(SYM) `pwd`/abcde.conf ${HOME}/.abcde.conf
inst-ackrc:
	 $(SYM) `pwd`/ackrc ${HOME}/.ackrc
inst-bash:
	[[ -d ${HOME}/dev/bash-git-prompt/ ]] || git clone https://github.com/magicmonty/bash-git-prompt.git ${HOME}/dev/bash-git-prompt/ 
	pushd ${HOME}/dev/bash-git-prompt/ \
	    && git fetch --prune --all \
	    && git merge --ff-only origin/master \
	    && popd
inst-beets:
	mkdir -p ${HOME}/.config/beets
	$(SYM) `pwd`/beets_config.yaml ${HOME}/.config/beets/config.yaml
inst-csirc:
	$(SYM) `pwd`/csirc ${HOME}/.csirc
inst-gitconfig:
	$(SYM) `pwd`/gitconfig ${HOME}/.gitconfig
inst-jupyter-css:
	mkdir -p ${HOME}/.jupyter/custom
	$(SYM) `pwd`/jupyter_notebook_theme.css ${HOME}/.jupyter/custom/custom.css
#inst-marblemouse:
#	sudo $(SYM) `pwd`/50-marblemouse.conf /usr/share/X11/xorg.conf.d/
inst-matplotlibrc:
	mkdir -p ${HOME}/.config/matplotlib/
	$(SYM) `pwd`/matplotlibrc ${HOME}/.config/matplotlib/matplotlibrc
inst-mpd:
	mkdir -p ${HOME}/.config/mpd
	$(SYM) `pwd`/mpd/mpd.conf ${HOME}/.config/mpd/mpd.conf
	mkdir -p ${HOME}/.config/mpdscribble
	$(SYM) `pwd`/mpd/mpdscribble.conf.anon ${HOME}/.config/mpdscribble/mpdscribble.conf.anon
	mkdir -p ${HOME}/.config/ncmpcpp/
	$(SYM) `pwd`/mpd/ncmpcpp_config ${HOME}/.config/ncmpcpp/config
inst-rprofile:
	$(SYM) `pwd`/RProfile ${HOME}/.RProfile
inst-todotxt:
	mkdir -p ${HOME}/.todo
	$(SYM) `pwd`/todo.cfg ${HOME}/.todo/config
	$(SYM) `pwd`/todo.actions.d ${HOME}/.todo.actions.d
inst-tmux:
	[ -d ~/.tmux/plugins/tpm ] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	pushd ~/.tmux/plugins/tpm \
	    && git fetch --prune --all \
	    && git merge --ff-only origin/master \
	    && popd
	$(SYM) `pwd`/tmux.conf ${HOME}/.tmux.conf
inst-vim:
	$(SYM) `pwd`/vimrc ${HOME}/.vimrc
	mkdir -p ${HOME}/.vim
	$(SYM) `pwd`/vim-ftplugin ${HOME}/.vim/ftplugin
	$(SYM) `pwd`/vim-syntax ${HOME}/.vim/syntax
	$(SYM) `pwd`/vim-after ${HOME}/.vim/after
	$(SYM) `pwd`/vim-autoload ${HOME}/.vim/autoload
	mkdir -p ${HOME}/.config
	$(SYM) ${HOME}/.vim ${HOME}/.config/nvim
	$(SYM) ${HOME}/.vimrc ${HOME}/.config/nvim/init.vim
inst-weechat:
	mkdir -p ${HOME}/.weechat/
	$(SYM) `pwd`/weechat/irc.conf ${HOME}/.weechat/irc.conf
	$(SYM) `pwd`/weechat/weechat.conf ${HOME}/.weechat/weechat.conf
inst-xinitrc:
	$(SYM) `pwd`/xinitrc ${HOME}/.xinitrc


# TO ADD:
#bashrc
#50-synaptics.conf
#99-nozap.conf
#lyx_user.bind
