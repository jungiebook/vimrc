set nocompatible

" run the following to install vim/plugged
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"   http://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" to install new plugins add to the list,
" :w, :source %, :PlugInstall
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/goyo.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-eunuch'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'Yggdroot/indentLine'
" have to install fuzzy first
" this involves sources bashrc and zshrc - if zshrc throws an error
" enter 'zsh' in terminal, and try sourcing the zshrc file again
" source ~/.zshrc
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'artur-shaik/vim-javacomplete2'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'vim-ctrlspace/vim-ctrlspace'

" fb
Plug 'flowtype/vim-flow'

call plug#end()

" USER PREFERENCEs
set guifont=Ubuntu\ Mono\ for\ Powerline:h13
set modelines=0

" default to regex searh replace affecting all versions of a string within the same line
set gdefault

" show visual char for tabs, trails
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

" set up color scheme
" set background=dark
set background=dark
let g:seoul256_background = 236
color seoul256

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)
"
" incsearch.vim x fuzzy x vim-easymotion
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzy#converter()],
  \   'modules': [incsearch#config#easymotion#module()],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())


" find-as-you-type-search
set incsearch

" case insensitive search
set ignorecase

" case-sensitive search if i specificy case in search
set smartcase

" highlight search match
set hlsearch

" set mapleader (NERDcommenter ,cc to comment)
let mapleader=","
set timeout timeoutlen=1500

" Remove trailing whitespaces on write
au BufWritePre <buffer> :call setline(1, map(getline(1,"$"), 'substitute(v:val, "\\s\\+$","","")'))

" setting up indent guide lines
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" SETTING UP NERDCOMMENTEr
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

function! s:InitLineNumbering()
  let l:my_window = winnr()
  windo setlocal number
  exec l:my_window . 'wincmd w'
  setlocal relativenumber
endfunction

augroup MyLineNumbers
  au!
  autocmd VimEnter * call <SID>InitLineNumbering()
  autocmd BufEnter,WinEnter * setlocal relativenumber
  autocmd FileType help setlocal relativenumber
  autocmd WinLeave * setlocal number
augroup END

set numberwidth=4
set mouse=a

set history=200
set hidden
set showcmd
set backspace=indent,eol,start
set smarttab
set autoindent nocindent nosmartindent
let is_bash=1
set visualbell
set cursorline
set wildignore+=*/tmp/*,*.so,*.swp,*/buck-out/*,*/buck-cache/*

 map <C-H> 3h
 map <C-J> 3j
 map <C-K> 3k
 map <C-L> 3l

 let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"
let g:ctrlp_max_files=200000
let g:ctrlp_working_path_mode = ''

" for NERDcommenter
filetype plugin on

augroup PersonalFileTypeSettings
   au!
   autocmd FileType mail,text,python,gitcommit,cpp,java,sh,vim,puppet,xml setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
   autocmd FileType java setlocal textwidth=100
augroup END

autocmd FileType java setlocal omnifunc=javacomplete#Complete

