set nocompatible " Disable Vi compatibility

" Vundle config
" =============
" Vundle used to manage Vim plugins.  To install:
" $ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
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

"Bundle 'godlygeek/tabular' " Needed for vim-markdown
"Bundle 'plasticboy/vim-markdown'  " To try using built-in Markdown support (by
"tpope) rather than plasticboy/vim-markdown due to issue #126 with the latter

Bundle 'suan/vim-instant-markdown'
" Preview markdown files in an (automatically opened) browser tab
" Do not always update the display in realtime; only refresh if no keys
" pressed for a while, left insert mode a while ago or file is saved
let g:instant_markdown_slow = 1
" Do not automatically launch a preview browser tab when open a markdown file;
" instead manually trigger the preview with :InstantMarkdownPreview
let g:instant_markdown_autostart = 0

Bundle 'nelstrom/vim-markdown-folding'
" Markdown folding

Bundle 'klen/python-mode'
"python-mode includes pylint, rope, pydoc, pyflakes, pep8, and mccabe for
"features like static analysis, refactoring, folding, completion,
"documentation, and more.

Bundle 'tshirtman/vim-cython'
"syntax file for cython

Bundle 'vim-scripts/MatlabFilesEdition'
"Matlab: 
" - syntax highlighting
" - correct settings for matchit.vim for matching if/end and for/end blocks
"   (using e.g. %), 
" - correct indentation, integration of mlint (Matlab code checker) with the
"   :make command, 
" - tag support, 
" - help file.

Bundle 'guns/vim-clojure-static'
" - Augmentable syntax highlighting for Clojure and ClojureScript buffers.
" - Configurable Clojure-specific indentation.
" - Basic insert mode completion for special forms and public vars in
"   clojure.core.
" - 3rd party extensions inc. Rainbow Parentheses and Extended Syntax
"   Highlighting

Bundle 'tpope/vim-fireplace'
"Connect to Clojure (n)REPL

Bundle 'tpope/vim-salve'
"Static Vim support for Leiningen and Boot (the latter being build tooling for
"Clojure)

Bundle 'vim-scripts/paredit.vim'
"Structured editing of Lisp S-expressions in Vim.  Useful for Clojure coding.

Bundle 'editorconfig/editorconfig-vim'
"EditorConfig helps developers define and maintain consistent coding styles
"between different editors and IDEs. 

Bundle 'derekwyatt/vim-scala'

Bundle 'drmikehenry/vim-extline'
"vim-extline: The following mappings apply in Visual and Insert modes (but,
"notably, NOT in Normal mode):
"CTRL-L CTRL-L Auto-line update
"CTRL-L CTRL-H Horizontal line update
"CTRL-L CTRL-U Change to underlined title
"CTRL-L CTRL-O Change to overlined title
"CTRL-L CTRL-I Change to underlined and overlined title
"CTRL-L = Force Section heading (level 1)
"CTRL-L 1 or CTRL-L - Force Subsection heading (level 2)
"CTRL-L 2 or CTRL-L ^ Force Subsubsection heading (level 3)
"CTRL-L 3 or CTRL-L " Force Paragraph heading (level 4)
"CTRL-L 4 or CTRL-L ' Force level 5 heading (level 5)
"CTRL-L 5

Bundle 'vim-scripts/taglist.vim'
"Source code browser plugin

Bundle 'altercation/vim-colors-solarized'
"Well-designed 16-color palette (see http://ethanschoonover.com/solarized)

Bundle 'freitass/todo.txt-vim'
"todo.txt management
"localleader is \ by default
"<localleader>s Sort the file
"<localleader>s+ Sort the file on +Projects
"<localleader>s@ Sort the file on @Contexts
"<localleader>sd Sort the file on dates
"<localleader>sdd Sort the file on due dates
"<localleader>j Decrease the priority of the current line
"<localleader>k Increase the priority of the current line
"<localleader>a Add the priority (A) to the current line
"<localleader>b Add the priority (B) to the current line
"<localleader>c Add the priority (C) to the current line
"<localleader>d Set current task's creation date to the current date
"date<tab> (Insert mode) Insert the current date
"<localleader>x Mark current task as done
"<localleader>X Mark all tasks as done
"<localleader>D Move completed tasks to done.txt

Bundle 'tpope/vim-surround'
"Add, change and delete 'surroundings' (parentheses, brackets, quotes, XML
"tags, and more)
" cs"' change double to single quotes
" cs'<q> change single quotes to html tag quotes
" cst" change html tag pair to double quotes
" ds" delete quotes
" ysiw] surround unsurrounded word in square brackets
" cs]{ change surroundings from [] to {} (use { if want extra space)
" yssb or yss) wrap line in parentheses
" ds{ds) revert to original text
" ysiw<em> emphasise word
" Visual mode: select text then e.g. S<p class="important">

Bundle 'tpope/vim-repeat'
"Enable repeating supported plugin maps with "."
"Allows repeating of e.g. surround.vim commands

Bundle 'embear/vim-foldsearch'
"Fold all but lines matching a pattern
"Useful for filtering when viewing todo.txt
" :Fs Show lines which contain the word under the cursor.
" :Fp Show the lines that contain the given regular expression.
" :FS Show the lines that contain spelling errors.
" :Fl Fold again with the last used pattern
" :Fc Show or modify current context lines around matching pattern.
" :Fi Increment context by one line.
" :Fd Decrement context by one line.
" :Fe Set modified fold options to their previous value and end foldsearch.

call vundle#end()

filetype plugin indent on " Enable per-filetype indentation
syntax on " Enable syntax highlighting
" Toggle numbering with F3
noremap <F3> :set invnumber<CR>
inoremap <F3> <C-O>:set invnumber<CR>

" (G)UI settings
set laststatus=2 " Show status line even when only one window shown
set ruler " Display the cursor position on the last line of the screen or in 
          "the status line of a window
set showmode " Show the mode that vim is in (Insert, Replace, Visual)
set hlsearch " Highlight searches
set bg=dark "Set background to dark
if has('gui_running') " Set GUI font and colorscheme
  set guifont=Hack\ 10,OpenDyslexicMono\ 9,Ubuntu\ Mono\ 12,Courier_New:h10:cANSI
  colorscheme solarized
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

" ctags setup (enabled by taglist.vim plugin; see Vundle config)
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 35
" To show/hid tag list
nnoremap <F4> :TlistToggle<cr>
" Regenerate ctags file
nnoremap <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
filetype plugin on

" Insert date and time (F5) or just date (F6)
nnoremap <F5> "=strftime("%Y-%m-%d %H:%M")<CR>P
inoremap <F5> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>
nnoremap <F6> "=strftime("%Y-%m-%d")<CR>P
inoremap <F6> <C-R>=strftime("%Y-%m-%d")<CR>

" Toggle automatic spell checking
nnoremap <F7> :setlocal spell! spelllang=en_gb<CR>
inoremap <F7> <Esc>:setlocal spell! spelllang=en_gb<CR>a

" Enable folding in vim-markdown
"let g:vim_markdown_folding_disabled=1

" Turn off Rope autoimport until pymode github issue 525 fixed
let g:pymode_rope_autoimport = 0
" Not doing the trick, so disable Rope alltogether
let g:pymode_rope = 0

" Other Python Mode options
"   Trim unused white spaces on save
let g:pymode_trim_whitespaces = 1
" let g:pymode_python = 'python3'
let g:pymode_indent = 1
let g:pymode_folding = 1
let g:pymode_motion = 1
"   Show docs for current word by pydoc using 'K'
let g:pymode_doc = 1
"   Automatic virtualenv detection
let g:pymode_virtualenv = 1
"   Run current buffer/selection with '<leader>r'
let g:pymode_run = 1
"   Insert/remove breakpoint with '<leader>b'
let g:pymode_breakpoint = 1


" Allow following of links using gx
let g:netrw_browsex_viewer = "/usr/bin/x-www-browser"

" Easier way to return to normal mode 
inoremap jk <esc>

" Syntax highlighting for CANARY Event Detection System files
au BufRead,BufNewFile *.edsx setfiletype xml
au BufRead,BufNewFile *.edsy setfiletype yaml
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
autocmd FileType yml setlocal shiftwidth=2 tabstop=2

" Smaller shiftwidth and tabstop for Markdown
autocmd FileType md setlocal shiftwidth=2 tabstop=2

set encoding=utf-8  " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file.

" Enable syntax highlighting and indentation when using tpope/vim-markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown autoindent formatoptions-=or nocindent

" Small tabs in HTML
au FileType html,css setlocal shiftwidth=2 tabstop=2

" Show size of visual selection
set showcmd
