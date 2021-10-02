if exists('+compatible') && &compatible
    set nocompatible
endif

"disable vim's native pack feature"
set packpath=
"allow opening new buffer without saving current editing file
set hidden
filetype plugin indent on

set fenc=utf-8

syntax on
colorscheme PaperColor
set background=dark
"show 256 colors in terminal"
set t_Co=256

"show terminal title like  /foo/bar/bazz..."
set title

"show space, line end"
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
"show line numbers"
set number

"show cursor position"
set ruler

set whichwrap=b,s,h,l,<,>,[,]

"tab = 4 space"
set tabstop=4

"tab = 4 space"
set expandtab

"Indnet"
set smartindent

set shiftwidth=4

"show beep visually"
set visualbell

"back to top when reach end on search"
set wrapscan

"ignore case on search"
set ignorecase

"emphasize corresponding brachet and brace"
set showmatch

"use slash as path separator(for Windows)"
set shellslash

"show cmd on status line"
set showcmd

"show candidates over statusline"
set wildmenu

"highlight search results"
set hlsearch

"set ctrl + n as open/close file tree
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>


"search incrementally"
set incsearch

"highlight cursor line"
set cursorline

"show new window on right side"
set splitright

"add EOF on save"
if v:version >= 800
    set fixendofline
endif

if has('unix')
    set fileformat=unix
    set fileencoding=utf-8
endif

"status line configs"
set laststatus=2

set statusline=[%n]

"show file name"
set statusline+=%<%F

"show modification status"
set statusline+=%m

"show [Preview] on preview page"
set statusline+=%w

"show [help] on help page"
set statusline+=%h

set statusline+=[%{&fileformat}]

set statusline+=%y

"align followings right"
set statusline+=%=

set statusline+=%{fugitive#statusline()}

set statusline+=%1l


"key binds"

"split windows"
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap ss :<C-u>sp<CR><C-w>j
nnoremap sv :<C-u>vs<CR><C-w>l
nnoremap <C-n> :Ntree .<CR>

"lsp shortcuts"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


"if 1 show like ls -la"
let g:netrw_liststyle=1

let g:netrw_altv = 1

let g:netrw_browse_split = 3
"hide header"
let g:netrw_banner=0
"show file size as (K,M,G)format"
let g:netrw_sizestyle="H"
"format time"
let g:netrw_timefmt="%Y/%m/%d %H:%M:%S"
"show preview window vertically"
let g:netrw_preview=1

let g:airline#extensions#tabline#enabled=1
let g:airline_theme='papercolor'
let g:fern#renderer='nerdfont'
let g:fern#default_hidden=1
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>


call plug#begin()
"tree viewer"
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'

"git support"
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

"theme related"
Plug 'NLKNguyen/papercolor-theme'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'

"lsp related"
"note: need node and yarn"
Plug 'neoclide/coc.nvim',{'branch':'release','do': { -> coc#util#install()}}

"scala related"
"completion,jump to definition, etc"
Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
"syntax highlighting"
Plug 'derekwyatt/vim-scala'

"window management"
Plug 'simeji/winresizer'

call plug#end()

autocmd BufNewFile,BufRead *.sc set filetype=scala

