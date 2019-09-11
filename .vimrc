syntax enable 

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces

set number              " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line

filetype indent on      " load filetype-specific indent files

set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" set foldenable          " enable folding
" set foldlevelstart=10   " open most folds by default


" ====================================================== "
"                   Rainbow.vim settings                 "
" ====================================================== "
map <leader>' :RainbowToggle<cr>
let g:rainbow_active = 1 
let g:rainbow_conf = {
    \   'guifgs': ['lightgreen', 'darkmagenta', 'darkred', 'darkgreen', 'darkblue', 'red', 'magenta'],
    \   'ctermfgs': ['lightgreen', 'darkmagenta', 'darkred', 'darkgreen', 'darkblue', 'red', 'magenta'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \}



" Strip trailing whitespace and newlines on save
fun! <SID>StripTrailingWhitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    %s/\($\n\s*\)\+\%$//e
    call cursor(l, c)
endfun


" Language bindings
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md :call <SID>StripTrailingWhitespace()
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd FileType python map <buffer> <F3> :call flake8#Flake8()<CR>
    autocmd FileType python map <buffer> <F4> :call flake8#Flake8UnplaceMarkers()<CR>
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END


highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
match OverLength /\%100v.*/


" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif


" vim-plug plugins
call plug#begin('~/.vim/plugins')

Plug 'luochen1990/rainbow'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'nvie/vim-flake8'

call plug#end()

let g:flake8_quickfix_location="topleft"
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1

" python from powerline.vim import setup as powerline_setup
" python powerline_setup()
" python del powerline_setup


" Font
set gfn=:Hack\ 8



function SpecialPaste()
    echo "Set paste!"
    set paste
    <i>
    <C-S-v>
    set nopaste
    return ""
endfunction


:nmap <leader>xx "=SpecialPaste()
