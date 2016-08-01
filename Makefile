CP = cp --backup=numbered --one-file-system --verbose --update --interactive

all: inst-ackrc inst-beets inst-csirc inst-gitconfig inst-jupyter-css inst-marblemouse inst-matplotlibrc inst-mpd inst-rprofile inst-todotxt inst-tmux inst-vim inst-weechat inst-xinitrc 

inst-ackrc:
	 $(CP) `pwd`/ackrc ${HOME}/.ackrc
inst-beets:
	mkdir -p ${HOME}/.config/beets
	$(CP) `pwd`/beets_config.yaml ${HOME}/.config/beets/config.yaml
inst-csirc:
	$(CP) `pwd`/csirc ${HOME}/.csirc
inst-gitconfig:
	$(CP) `pwd`/gitconfig ${HOME}/.gitconfig
inst-jupyter-css:
	mkdir -p ${HOME}/.jupyter/custom
	$(CP) `pwd`/jupyter_notebook_theme.css ${HOME}/.jupyter/custom/custom.css
inst-marblemouse:
	sudo $(CP) `pwd`/50-marblemouse.conf /usr/share/X11/xorg.conf.d/
inst-matplotlibrc:
	mkdir -p ${HOME}/.config/matplotlib/
	$(CP) `pwd`/matplotlibrc ${HOME}/.config/matplotlib/matplotlibrc
inst-mpd:
	mkdir -p ${HOME}/.config/mpd
	$(CP) `pwd`/mpd/mpd.conf ${HOME}/.config/mpd/mpd.conf
	mkdir -p ${HOME}/.mpdscribble
	$(CP) `pwd`/mpd/mpdscribble.conf.anon ${HOME}/.mpdscribble/mpdscribble.conf.anon
	mkdir -p ${HOME}/.ncmpcpp/
	$(CP) `pwd`/mpd/ncmpcpp_config ${HOME}/.ncmpcpp/config
inst-rprofile:
	$(CP) `pwd`/RProfile ${HOME}/.RProfile
inst-todotxt:
	mkdir -p ${HOME}/.todo
	$(CP) `pwd`/todo.cfg ${HOME}/.todo/config
	$(CP) -rT `pwd`/todo.actions.d ${HOME}/.todo.actions.d
inst-tmux:
	$(CP) `pwd`/tmux.conf ${HOME}/.tmux.conf
inst-vim:
	ln -siTn `pwd`/vimrc ${HOME}/.vimrc
	mkdir -p ${HOME}/.vim
	ln -siTn -rT `pwd`/vim-ftplugin ${HOME}/.vim/ftplugin
	ln -siTn -rT `pwd`/vim-syntax ${HOME}/.vim/syntax
	ln -siTn `pwd`/vim-after ${HOME}/.vim/after
	ln -siTn `pwd`/vim-autoload ${HOME}/.vim/autoload
inst-weechat:
	mkdir -p ${HOME}/.weechat/
	$(CP) `pwd`/weechat/irc.conf ${HOME}/.weechat/
	$(CP) `pwd`/weechat/weechat.conf ${HOME}/.weechat/
inst-xinitrc:
	$(CP) `pwd`/xinitrc ${HOME}/.xinitrc


# TO ADD:
#bashrc
#50-synaptics.conf
#99-nozap.conf
#lyx_user.bind
