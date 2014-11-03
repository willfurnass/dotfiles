" Vundle config
" =============
" Vundle used to manage Vim plugins.
"
set nocompatible " Disable Vi compatibility
filetype off " Disable filetype detection
" Add Vundle to Vim runtimepath
set runtimepath+=~/.vim/bundle/Vundle.vim
" Make % match more than just single chars.  Can match words and regexes.
" Also, matching treats strings and comments (as recognized by the
" syntax highlighting mechanism) intelligently.
" The default ftplugins include settings for several languages:
" Ada, ASP with VBS, Csh, DTD, Essbase, Fortran, HTML, JSP
" (same as HTML), LaTeX, Lua, Pascal, SGML, Shell, Tcsh, Vim, XML. 
runtime macros/matchit.vim
call vundle#begin()
" Vim packages to automatically install/update
Bundle 'gmarik/Vundle.vim'
"Bundle 'klen/python-mode'
Bundle 'vim-scripts/MatlabFilesEdition'
Bundle 'tshirtman/vim-cython'
Bundle 'guns/vim-clojure-static'
call vundle#end()

filetype plugin indent on " Enable per-filetype indentation
syntax on " Enable syntax highlighting
set number " Enable line numbering

" (G)UI settings
set laststatus=2 " Show status line even when only one window shown
set ruler " Display the cursor position on the last line of the screen or in 
          "the status line of a window
set showmode " Show the mode that vim is in (Insert, Replace, Visual)
set hlsearch " Highlight searches
set bg=dark "Set background to dark
if has('gui_running') " Set GUI font and colorscheme
  set guifont="Ubuntu Mono 12"
  colorscheme peachpuff
endif

" Movement, spacing, indents, pasting
set expandtab
set shiftwidth=4
set softtabstop=4
set cindent
set backspace=2
" Paste blocks without autoindent introducing extraneous spacing
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
autocmd FileType make setlocal noexpandtab
" Disable cursor keys
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>
"set textwidth=80 " Limit textwidth to 80 chars

" Enable parsing of vim modelines at the top of source files
set modeline

" Buffer management
" Switch buffers using F10
set wildchar=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>
nnoremap <F10> :b <C-Z>

" ctags setup
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 35
" To show/hid tag list
map <F4> :TlistToggle<cr>
" Regenerate ctags file
map <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
filetype plugin on

" Insert date
nnoremap <F5> "=strftime("%Y-%m-%d %H:%M")<CR>P
inoremap <F5> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>
