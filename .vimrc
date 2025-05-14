call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'jiangmiao/auto-pairs'

Plug 'easymotion/vim-easymotion'

"colorschemes
Plug 'morhetz/gruvbox'

call plug#end()

syntax enable
"let g:mapleader=','
colorscheme gruvbox
set background=dark

set number
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
set smartindent

set cindent
set list lcs=tab:\|\

set title "отображает название файла вверху окна

"mappings
map <Leader> <Plug>(easymotion-prefix)

" enter to normal mode with 'jj'
" inoremap jj <ESC>
" Deleted. To enter normal mode, use 'Ctrl+['

" ugly hack to start newline and keep indent
nnoremap o ox<BS>
nnoremap O Ox<BS>
nnoremap <cr> <cr>x<BS>

autocmd filetype cpp nnoremap <F4> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' -g3 &&  ./'.shellescape('%:r')<CR>
autocmd FileType cpp nnoremap <F5> :exec '!gdb -q BuildCpp/'.shellescape('%:r').'.out'<CR>

" autocmd BufRead *.cpp autocmd FileType cpp nnoremap <F9> if &modified | :w | endif <CR>
" :make - может улучшить обычную сборку
" autocmd FileType cpp nnoremap <F9> :exec '!mkdir -p BuildCpp; cp ~/.local/templates/MakefileCpp ./BuildCpp/MakefileCpp_'.shellescape('%:r').'; sed -i s/place_to_insert_name/'.shellescape('%:r').'/ ./BuildCpp/MakefileCpp_'.shellescape('%:r') <CR> :make -f BuildCpp/MakefileCpp_'%:r'<CR>
"
" старая версия с копированием (не была закомментированна)
" autocmd FileType cpp nnoremap <F9> :exec '!mkdir -p BuildCpp; cp ~/.local/templates/MakefileCpp ./BuildCpp/MakefileCpp_'.shellescape('%:r').'; sed -i s/place_to_insert_name/'.shellescape('%:r').'/ ./BuildCpp/MakefileCpp_'.shellescape('%:r').'; make -s -f BuildCpp/MakefileCpp_'.shellescape('%:r')<CR>
autocmd FileType cpp nnoremap <F9> :exec '!make -s -f BuildCpp/MakefileCpp_'.shellescape('%:r')<CR>

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

