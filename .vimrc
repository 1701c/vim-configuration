" Modeline and Notes {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
"  _____                ______      _  ______          _
" |  ___|               |  _  \    | | | ___ \        ( )
" | |____   ____ _ _ __ | | | |___ | |_| |_/ / __ ___ |/ ___
" |  __\ \ / / _` | '_ \| | | / _ \| __|  __/ '__/ _ \  / __|
" | |___\ V / (_| | | | | |/ / (_) | |_| |  | | | (_) | \__ \
" \____/ \_/ \__,_|_| |_|___/ \___/ \__\_|  |_|  \___/  |___/
"            _                              __ _
"           (_)                            / _(_)
"     __   ___ _ __ ___     ___ ___  _ __ | |_ _  __ _
"     \ \ / / | '_ ` _ \   / __/ _ \| '_ \|  _| |/ _` |
"      \ V /| | | | | | | | (_| (_) | | | | | | | (_| |
"       \_/ |_|_| |_| |_|  \___\___/|_| |_|_| |_|\__, |
"                                                 __/ |
"                                                |___/
"
"   This is the personal vim config of Evan Coury (aka EvanDotPro).
"
"   Author: Evan Coury, http://blog.evan.pro/
"      URL: https://github.com/EvanDotPro/vim-configuration
"
"   Special thanks to:
"
"    - Steve Francia for spf13-vim (https://github.com/spf13/spf13-vim)
"    - Marc Weber for Vundle(https://github.com/gmarik/vundle)
"    - Aleksey Khudyakov (aka Xerkus) for adding git-treeish support to Vundle
"    - All of the authors of the other amazing Vim plugins I use every day.
"
" }

" Environment {

" Basics {
    set nocompatible                   " Use ViMproved, don't emulate old vi
    let $VIMHOME = split(&rtp, ',')[0] " Find the Vim path
" }

" Vundle {
    filetype off " Turned back on after loading bundles
    set rtp+=$VIMHOME/bundle/vundle
    call vundle#rc()
    Bundle 'EvanDotPro/vundle', 'feature/refactor-git-treeish-support', {'local': 1}
" }

" Local Configuration {
    if filereadable(expand("$VIMHOME/config.local.vim"))
        source $VIMHOME/config.local.vim
    endif
" }

" }

" Bundles {

" You can define just the groups you need in your config.local.vim
if !exists('g:bundle_groups')
    let g:bundle_groups=['general', 'themes', 'programming', 'php', 'html']
endif


if !exists('g:override_bundles')

    " General
        if count(g:bundle_groups, 'general')
            Bundle 'scrooloose/nerdtree'
            Bundle 'EvanDotPro/vim-zoom'
            Bundle 'EvanDotPro/nerdtree-symlink',
            Bundle 'scrooloose/nerdcommenter',
            Bundle 'kien/ctrlp.vim'
            "Bundle 'Lokaltog/vim-powerline', 'develop'
            Bundle 'L9', '1.1'
            Bundle 'bling/vim-airline'
            "Bundle 'FuzzyFinder', '4.2.2'
            "Bundle 'terryma/vim-multiple-cursors'
            Bundle 'sjl/gundo.vim'
            Bundle 'elzr/vim-json'
            Bundle 'codenothing/jsonlint'
            Bundle 'honza/vim-snippets'
        endif

    " Themes
        if count(g:bundle_groups, 'themes')
            Bundle 'Lucius', '7.1.1'
            Bundle 'altercation/vim-colors-solarized'
            Bundle 'spf13/vim-colors'
        endif

    " General Programming
        if count(g:bundle_groups, 'programming')
            Bundle 'tpope/vim-fugitive'
            Bundle 'airblade/vim-gitgutter'
            Bundle 'godlygeek/tabular'
            Bundle 'mattn/webapi-vim'
            Bundle 'mattn/gist-vim'
            Bundle 'mattn/emmet-vim'
            Bundle 'tpope/vim-markdown'
            Bundle 'scrooloose/syntastic', '3.4.0'
            Bundle 'joonty/vdebug'
            Bundle 'nathanaelkane/vim-indent-guides'
            Bundle 'solarnz/thrift.vim'
            Bundle 'taglist.vim'
            "Bundle 'Valloric/YouCompleteMe'
            Bundle 'Shougo/neocomplete.vim'
        endif

    " PHP
        if count(g:bundle_groups, 'php')
            "PHP syntax highlighting for 5.4, 5.5+
            Bundle 'Shougo/vimproc.vim'
            Bundle 'Shougo/unite.vim'
            Bundle 'm2mdas/phpcomplete-extended'
            Bundle 'm2mdas/phpcomplete-extended-laravel' 
            Bundle 'arnaud-lb/vim-php-namespace'
            Bundle 'StanAngeloff/php.vim'
            Bundle 'EvanDotPro/php_getset.vim'
            Bundle 'mikehaertl/pdv-standalone'
            Bundle 'vim-php/vim-php-refactoring'
            Bundle 'joonty/vim-phpqa.git'
            Bundle 'vim-php/vim-composer'
            Bundle 'sniphpets/sniphpets'
            Bundle 'sniphpets/sniphpets-common',
            "Bundle 'sniphpets/sniphpets-postfix-codes'

        endif
    " HTML
        if count(g:bundle_groups, 'html')
            Bundle 'othree/html5.vim'
        endif

endif

" }

" General {

filetype plugin indent on " Automatically detect file types.
syntax on                 " syntax highlighting
set mouse=a               " automatically enable mouse usage
set virtualedit=all       " allow for cursor beyond last character
set history=1000          " Store a ton of history (default is 20)
set hidden                " allow buffer switching without saving
scriptencoding utf-8
set encoding=utf-8
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
autocmd VimEnter * execute "cd" fnameescape(g:startDir)
let g:airline#extensions#tabline#enabled = 1
" }

" Vim UI {

set shortmess+=I                       " Disable splash text
set t_Co=256                           " Fix colors in the terminal
set guifont=SourceCodePro-Bold\ 11         " Way better than monospace
silent color lucius                    " Vim colorscheme
let g:Powerline_colorscheme = 'lucius' " Powerline colorscheme
set laststatus=2                       " Always show status bar
set mousemodel=popup                   " Enable context menu

" Clean up the GUI in Gvim
if has("gui_running")
    set guioptions-=T
    set guioptions-=m
    set guioptions+=LlRrb " bug?
    set guioptions-=LlRrb
endif

set backspace=indent,eol,start " backspace for dummies
set linespace=0                " no extra spaces between rows
set number                     " line numbers on
set cpoptions+=$               " cool trick to show what you're replacing
set showmatch                  " show matching brackets/parenthesis
set showcmd                    " show multi-key commands as you type
set incsearch                  " find as you type search
set hlsearch                   " highlight search terms
set winminheight=0             " windows can be 0 line high
set ignorecase                 " case insensitive search
set smartcase                  " case sensitive when uc present
set wildmenu                   " show list instead of just completing
set wildmode=list:longest,full " command <Tab> completion, list matches, then longest common part, then all.
set scrolljump=5               " lines to scroll when cursor leaves screen
set scrolloff=3                " minimum lines to keep above and below cursor
set list                       " use the listchars settings
set listchars=tab:▸\           " show tabs
set colorcolumn=81
"color is for lucius dark
hi ColorColumn guibg=#292929

" }

" Formatting {

"set nowrap        " wrap long lines
set autoindent    " indent at the same level of the previous line
set shiftwidth=4  " use indents of 4 spaces
set expandtab     " tabs are spaces, not tabs
set tabstop=4     " an indentation every four columns
set softtabstop=4 " let backspace delete indent
" Remove trailing whitespaces and ^M chars
     autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml,phtml,vimrc autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
" }

" Key (re)Mappings {

" Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
nnoremap ; :

" Map F1 to Esc to prevent accidental opening of the help window
map  <F1> <Esc>
imap <F1> <Esc>

" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

" Clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" One less key-stroke for save
nmap <silent> <leader>w :w<CR>

" Easier copy/paste
map <leader>v "+gP
map <leader>c "+y

" Ctrl-a for select all
map <C-A> ggVG

" Ctrl-b for fuzzy-buffer match
map <C-B> :FufBuffer<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null
"nmap <silent> <leader>www :w!!<CR> " this causes a nasty delay before saving

" Toggle numbers.vim
nnoremap <F3> :NumbersToggle<CR>

" Support buffer switch on tab even if MiniBufExplorer is not used
if !vundle#hasBundle('minibufexpl') && has("gui_running")
    noremap <C-TAB>   :bnext<CR>
    noremap <C-S-TAB> :bprev<CR>
endif

" ZenCoding-vim
    map <C-z> <C-y>,

" pdv-standalone
nnoremap <C-y> :call PhpDocSingle()<CR>
vnoremap <C-y> :call PhpDocRange()<CR>

"unit test everything
nmap ,t :!clear && phpunit<cr>

"unit test highlighted method
nmap ,m yiw:!phpunit --filter ^R"<cr>
" }

" Plugins {

" NerdTree {
    map <C-e> :NERDTreeToggle<CR>
    map <leader>e :NERDTreeFind<CR>
    nmap <leader>nt :NERDTreeFind<CR>

    let NERDTreeShowBookmarks=1
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
    let NERDTreeMinimalUI=1
" }

" vim-gist {
    let g:gist_show_privates = 0
" }

" pdv-standalone {
    " use "" as parameter to turn tag off
    let g:pdv_cfg_php4guess=0
    let g:pdv_cfg_Package=" "
    let g:pdv_cfg_Author="Thomas Veilleux Thomas@perk.com"
    let g:pdv_cfg_Version="1.0.0"
    "let g:pdv_cfg_Copyright=""
    "let g:pdv_cfg_License=""
" }

" vim-php-namespace {
inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
noremap <Leader>u :call PhpInsertUse()<CR>
"}

" }

" Functions {

" Put all swap, backup, and view files in a central location
" Source: spf-13-vim (https://github.com/spf13/spf13-vim/blob/4f01f8f7a35736fc106a1735e076a83ac548e104/.vimrc#L552)
" Modified by Evan to better handle swap file paths for editing multiple
" files with the same filename.
function! InitializeDirectories()
    let parent = $VIMHOME
    let prefix = '.'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    for [dirname, settingname] in items(dir_list)
        let directory = parent . '/' . prefix . dirname . '/'
        if exists('*mkdir')
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo 'Warning: Unable to create backup directory: ' . directory
            echo 'Try: mkdir -p ' . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", 'g')
            " add trailing slashes to name swap files with full path
            exec 'set ' . settingname . '^=' . directory . '//'
        endif
    endfor
endfunction
call InitializeDirectories()

" Highlight trailing whitespace in red
" Source: http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" }

" Local Override {
if filereadable(expand("$VIMHOME/override.local.vim"))
    source $VIMHOME/override.local.vim
endif
" }
"


