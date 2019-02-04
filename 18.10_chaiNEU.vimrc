" -------------------------------

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'sentientmachine/Pretty-Vim-Python' "better syntax highlighting (e.g. molokai)
Plugin 'scrooloose/nerdcommenter'
Plugin 'lervag/vimtex'                  "for latex; shortcuts: https://github.com/lervag/vimtex
Plugin 'Vimjas/vim-python-pep8-indent'  "better pip8 indenting (for long arguments)
Plugin '907th/vim-auto-save'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'nikvdp/ejs-syntax'              "javascript syntax highlighting

"Plugin 'vim-syntastic/syntastic' "PEP8 checks
Plugin 'maralla/completor.vim'   "autocomplete - make sure to run 'pip install jedi'
"Plugin 'nvie/vim-flake8'
Plugin 'w0rp/ale' "requires pip install black, pip install pylint, flake8


" MUST tell completor local python library, e.g. in the virtualenv, for context
" of python installed library functions to appear
let g:completor_python_binary = '/home/rui/v3/lib/python3.6'
let g:completor_python_binary = '/home/rui/v3/bin/python'


" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'lervag/vimtex'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

nmap , :
command WQ wq
command Wq wq
command W w
command Q q


syntax on
filetype indent plugin on

set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent

"colorscheme desert
colorscheme molokai
highlight Comment cterm=bold
"highlight Comment cterm=bold

let mapleader=","
set nu
set mouse=a

nnoremap ,o :!pdflatex %<CR>

set wrap
set textwidth=80
set colorcolumn=80 " display line at textwidth


inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"


" make a statusline
hi StatusLine ctermbg=red ctermfg=black
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set laststatus=2 "put statusline two lines up

" let the tab at the top reflect the current file being edited
let &titlestring = @%
set title

imap jk <Esc>


"set list
" making it possible to see cursor when highlighting matching
"hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
hi MatchParen cterm=bold ctermbg=none ctermfg=none

" NOTE show whitespace with :set list

" create abbreviations for math. when you type the space, vim will expand


" automatically create equation environment. Used in inesrt mode
autocmd FileType tex    map!;b <ESC>bywi\begin{<ESC>ea}<CR>\end{}<ESC>PO
autocmd FileType tex    map!;m \begin{align}<Return>\end{align}<ESC>O
autocmd FileType tex    map!;a \begin{answer}<Return>\end{answer}<ESC>O



let g:auto_save_events = ["InsertLeave", "TextChanged", "TextChangedI", "CursorHold"]
" AutoSave is disabled by default, run :AutoSaveToggle to enable/disable it.
set updatetime=750
" \ll in normal mode to get
" \lv
" vim --servername vim test.tex
" ci} {asdf}
" cit <h2></h2>
" dac \boldface\mu ->  \mu (command)
" cse  change surrounding environment


" Bind F5 to save file if modified and execute python script in a buffer.
"nnoremap <silent> <F5> :call SaveAndExecutePython()<CR>
"vnoremap <silent> <F5> :<C-u>call SaveAndExecutePython()<CR>
"nnoremap ,p :w<CR>:!clear;python %<CR>
nnoremap ,p :call <SID>compile_and_run()<CR>
nnoremap ,e :!python %<cr>
" botright vertical pedit.



augroup SPACEVIM_ASYNCRUN
    autocmd!
    " Automatically open the quickfix window
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
augroup END

function! s:compile_and_run()
	set splitright
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! time python %"
    endif
    " ctrl-w H to move split to right
    "autocmd FileType qf wincmd L "move quickfix window to right
    "http://liuchengxu.org/posts/use-vim-as-a-python-ide/
endfunction

"au FileType qf wincmd H
"au FileType qf :vertical resize 50
"au FileType qf wincmd R


map <Leader>n :NERDTreeToggle<CR>

set iskeyword-=_


" ------------------------------- From vim -u DEFAULTS
" (https://github.com/vim/vim/blob/master/runtime/defaults.vim)
"
" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Recommended settings for new syntastic users
set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black', 'autopep8'],
\}

let g:ale_python_flake8_options="--ignore=E501,F401,W601,E266,W0611,E265,E402,W504"
"let g:pymode_lint_ignore=["E501","W601", "E266", "W0611", "E265", "E402"]

let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_open_list = 1 " list in the quickfix window, all the errors
"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1
" Set this in your vimrc file to disabling highlighting
let g:ale_set_highlights = 1
"let g:autopep8_ignore="E501,W293"

" Show 5 lines of errors (default: 10)
let g:ale_list_window_size = 5

"'add_blank_lines_for_python_control_statements' - Add blank lines before control statements.
"'autopep8' - Fix PEP8 issues with autopep8.
"'black' - Fix PEP8 issues with black.
"'isort' - Sort Python imports with isort.
"'yapf' - Fix Python files with yapf.
"'remove_trailing_lines' - Remove all blank lines at the end of a file.
"'trim_whitespace' - Remove all trailing whitespace characters at the end of every line.
