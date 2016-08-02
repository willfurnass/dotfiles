SYM = ln --symbolic --no-target-directory --no-dereference --force --backup=numbered

all: inst-ackrc inst-beets inst-csirc inst-gitconfig inst-jupyter-css inst-matplotlibrc inst-mpd inst-rprofile inst-todotxt inst-tmux inst-vim inst-weechat inst-xinitrc 
#inst-marblemouse 

inst-ackrc:
	 $(SYM) `pwd`/ackrc ${HOME}/.ackrc
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
	mkdir -p ${HOME}/.mpdscribble
	$(SYM) `pwd`/mpd/mpdscribble.conf.anon ${HOME}/.mpdscribble/mpdscribble.conf.anon
	mkdir -p ${HOME}/.ncmpcpp/
	$(SYM) `pwd`/mpd/ncmpcpp_config ${HOME}/.ncmpcpp/config
inst-rprofile:
	$(SYM) `pwd`/RProfile ${HOME}/.RProfile
inst-todotxt:
	mkdir -p ${HOME}/.todo
	$(SYM) `pwd`/todo.cfg ${HOME}/.todo/config
	$(SYM) `pwd`/todo.actions.d ${HOME}/.todo.actions.d
inst-tmux:
	$(SYM) `pwd`/tmux.conf ${HOME}/.tmux.conf
inst-vim:
	$(SYM) `pwd`/vimrc ${HOME}/.vimrc
	mkdir -p ${HOME}/.vim
	$(SYM) `pwd`/vim-ftplugin ${HOME}/.vim/ftplugin
	$(SYM) `pwd`/vim-syntax ${HOME}/.vim/syntax
	$(SYM) `pwd`/vim-after ${HOME}/.vim/after
	$(SYM) `pwd`/vim-autoload ${HOME}/.vim/autoload
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
