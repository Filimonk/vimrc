call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'jiangmiao/auto-pairs'

Plug 'easymotion/vim-easymotion'

" LSP core
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" Online man
Plug 'thinca/vim-ref'

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

" completion sets
set completeopt=menuone
    " ctags -R . 
    " создаст нам tags файл, после перезагрузки файла они подсосуться и можно будет
    " переходить <C-]> и выходить <C-t>
set tags=./tags;,tags;
    " Include paths for <C-x><C-i>
set path+=**
set path+=../include/**
    " Spell (only on demand via <C-x><C-k>)
set dictionary+=/usr/share/dict/words
  " Затычка, эти словари взял https://github.com/psliwka/vim-dirtytalk/tree/master
let &dictionary .= "," . join(glob("~/.vim/dict/*", 0, 1), ",")
    " Use LSP for omni-completion
set omnifunc=lsp#complete


" LSP settings
    " Серенькая полоска слева всегда отображается
set signcolumn=yes
    " LSP navigation
nnoremap gd :LspDefinition<CR>
nnoremap gD :LspDeclaration<CR>
nnoremap gr :LspReferences<CR>
    " LSP info
nnoremap K  :LspHover<CR>
    " LSP actions
nnoremap <leader>r :LspRename<CR>
nnoremap <leader>a :LspCodeAction<CR>
nnoremap <leader>f :LspDocumentFormat<CR>
    " LSP diagnostics
nnoremap <leader>e :LspNextDiagnostic<CR>
nnoremap <leader>E :LspPreviousDiagnostic<CR>
nnoremap <leader>d :LspDocumentDiagnostics<CR>
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_highlights_enabled = 1
  " Функция для перехода к текущей строке в зависимости от типа списка (после gr или <leader>q)
function! SmartJumpToChosenOpt()
    let win_info = getwininfo(win_getid())[0]
    if win_info.loclist
        execute ".:ll"
    elseif win_info.quickfix
        execute ".:cc"
    else
        echo "Это не loclist или quickfix окно"
    endif
endfunction
  " Переходить на выбранный вариант в quickfix или loclist
nnoremap <silent> g<CR> :call SmartJumpToChosenOpt()<CR>


" Устанавливаем cppreference.com как основной источник для C++
let g:ref_source_web = 'cppreference'
let g:ref_source_web_url_cpp = 'https://en.cppreference.com/w/cpp/'
" Клавиша для быстрого поиска
nmap <Leader>k <Plug>(ref-keyword)


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

