" vim configuration file
set nocompatible
set showmatch
set incsearch
syntax enable
set history=100
set backspace=eol,start,indent
set ruler
set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set wildmenu
set showcmd
set autoindent
set smartindent
set list listchars=tab:→\ ,trail:·

" colors
set t_Co=256
colorscheme wombat_t

" gvim options
if has('gui_running')
  set virtualedit=all
  set mouse=v
  set textwidth=80
  set lines=35 columns=90
  set guifont=Terminus\ 10
  colors wombat_g
  set suffixes=.bak,~,.swp,.o,.pyc
  set fileencodings=utf-8
  set termencoding=utf-8
  set mouse=v
endif

" pathogen: https://github.com/tpope/vim-pathogen
call pathogen#infect()
"filetype off
"call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"plugins
filetype plugin indent on

" hightlight after 80th column for python/C/perl/php
"highlight OverLength ctermbg=lightred ctermfg=black guibg=#FFD9D9
"au BufRead,BufNewFile *.py,*.c,*.h,*.pl,*.pm,*.php match OverLength /\%81v.\+/

" minibufexporer
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" taglist
nnoremap <silent> <F8> :TlistToggle<CR>

" tasklist
nnoremap <silent> <F7> :TaskList<CR>

" LaTeX Preview
" 'stolen' from Jelly's configs
autocmd FileType tex silent :! (file="%"; pdflatex % &>/dev/null && zathura "${file/.tex/.pdf}" &>/dev/null) &
command! Reload :! (pdflatex % &>/dev/null) &
au BufWritePost *.tex silent Reload

