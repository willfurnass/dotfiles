" Chicken Scheme setup
" 
" Based on http://wiki.call-cc.org/vim

" Use Chicken flavour of Scheme
let b:is_chicken=1

" Enable completion of identifier names using CTRL-P and CTRL-N
setl complete+=,k~/.vim/ftplugin/scheme-word-list

" VIM can be configured to find words in files which are mentioned in use or
" require-extension. In the example below, change the path to match your
" setup. 
setl include=\^\(\\(use\\\|require-extension\\)\\s\\+
setl includeexpr=substitute(v:fname,'$','.scm','')
setl path+=/var/lib/chicken/6
setl suffixesadd=.scm

" VIM already indents Scheme file well, except it can't recognise some CHICKEN
" keywords. We just have to add them.
setl lispwords+=let-values,condition-case,with-input-from-string
setl lispwords+=with-output-to-string,handle-exceptions,call/cc,rec,receive
setl lispwords+=call-with-output-file

" Use == to indent a toplevel S-expression
nmap <silent> == :call Scheme_indent_top_sexp()<cr>

" Indent a toplevel sexp.
fun! Scheme_indent_top_sexp()
	let pos = getpos('.')
	silent! exec "normal! 99[(=%"
	call setpos('.', pos)
endfun
