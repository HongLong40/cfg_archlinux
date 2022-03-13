set encoding=utf-8
scriptencoding utf-8
filetype indent on
set hidden
set nocompatible
"set nomodeline
set clipboard^=unnamed,unnamedplus

syntax on

" ----------------------------------------------------------------------------
" --- Color scheme, highlights, font and cursors -----------------------------
colorscheme industry
"highlight Normal guifg=#cfcfcf guibg=#010e17
highlight Normal guifg=#cfcfcf guibg=#01101c ctermbg=234
highlight LineNr guifg=DarkYellow
highlight CursorLineNr gui=none guifg=red cterm=none ctermfg=darkred
highlight CursorLine guibg=Grey15 cterm=none ctermbg=18
highlight iCursor guifg=bg guibg=red
highlight Folded  term=standout ctermfg=11 ctermbg=8 guifg=DarkRed guibg=DarkGrey
highlight MatchParen guibg=DarkBlue
highlight SpecialKey guifg=orange
highlight StatusLine gui=reverse guifg=#00bb00 cterm=reverse ctermfg=DarkGreen

if has('linux')
    " set guifont=Input\ Mono\ Light\ 11
    " set guifont=Cascadia\ Mono\ PL\ 12
    set guifont=JetBrains\ Mono\ Light\ 12
else
    " set guifont=InputMono_Light:h11:cANSI:qDRAFT
    set guifont=Cascadia_Mono:h12:cANSI:qDEFAULT
endif

set cursorline
set guicursor=n-v-c:block-Cursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:hor10-iCursor,r-cr:hor20-iCursor,a:blinkon0
set scrolloff=5

" --- Global variables -------------------------------------------------------
let g:rainbow_active = 1
let g:sql_type_default = 'sqlserver'

set timeoutlen=2000
set printoptions=left:20pt,right:20pt

" —-- Mappings —--------------------------------------------------------------
let mapleader = " "
nnoremap <silent> <leader>cc :set invcursorcolumn
nnoremap <silent> <leader>nn :set invnumber invrelativenumber
nnoremap <silent> <leader>rt :RainbowToggle
nnoremap <silent> <leader>sc :set invlist
nnoremap <silent> <leader>w  :w
nnoremap gb :ls:b 
nnoremap <silent> td :s/\[ \]/\[✓\]/j
nnoremap <silent> tu :s/\[✓\]/\[ \]/
nnoremap ; :
vnoremap ; :
vnoremap <silent> td :s/\[ \]/\[✓\]/
vnoremap <silent> tu :s/\[✓\]/\[ \]/

" --- Status Line ------------------------------------------------------------
set laststatus=2
set statusline=
set statusline+=\ %n\ -\ %<%f%h%M
set statusline+=%=
set statusline+=%{&fileencoding?&fileencoding:&encoding}
set statusline+=:%{&fileformat}\ %y
set statusline+=\ │\ %5.5l:%-3.3v
set statusline+=\ 

" --- Settings (general) -----------------------------------------------------
set splitbelow splitright
set title
set autoindent
set number relativenumber
set showmatch
set tabstop=4 softtabstop=4 smarttab shiftwidth=4 expandtab
set ignorecase smartcase
set backspace=indent,eol,start
"set listchars=eol:¶,tab:>·,trail:~,extends:>,precedes:<,space:⋅
set listchars=eol:¬,tab:⭾⋅,trail:~,extends:>,precedes:<,space:·

" —-- Folding ----------------------------------------------------------------
set foldmethod=marker
set foldmarker=--{,--}

" --- Abbreviations and Ligatures --------------------------------------------
iabbrev ... …
iabbrev ->  →
iabbrev bbb [ ]
iabbrev bvb [✓]

" —-- Window Navigation —-----------------------------------------------------
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-a> ggVG

"if !has('gui_running')
"    let g:powerline_loaded = 0
"    set showmode
"endif

if has('gui_running')
    " toolbar and scrollbars
    set guioptions-=T     " remove toolbar
    set guioptions-=L     " left scroll bar
    set guioptions-=r     " right scroll bar
    set guioptions-=b     " bottom scroll bar
    set guioptions-=h     " only calculate bottom scroll size of current line
    set noshowmode        " to avoid duplication in powerline status bar
endif

set noshowmode
