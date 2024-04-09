call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'jiangmiao/auto-pairs'

Plug 'easymotion/vim-easymotion'

"colorschemes
Plug 'morhetz/gruvbox'

call plug#end()

syntax enable 
let g:mapleader=','
colorscheme gruvbox
set background=dark

set number 
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
set smartindent

"mappings
map <Leader> <Plug>(easymotion-prefix)

" exit to normal mode with 'jj'
inoremap jj <ESC>

autocmd filetype cpp nnoremap <F9> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' -g3 &&  ./'.shellescape('%:r')<CR>

" nerdtree
map <C-n> :NERDTreeToggle<CR>

map <silent> <C-h> :call WinMove('h')<CR>
map <silent> <C-j> :call WinMove('j')<CR>
map <silent> <C-k> :call WinMove('k')<CR>
map <silent> <C-l> :call WinMove('l')<CR>

function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))

    else 
      wincmd s
    endif
  endif
endfunction
