" Evan Coury's Vim Configuration
" http://www.evan.pro/
"
" This configuration is primarily geared towards PHP / web developers, but
" not by any means limited to such.

" This needs to come before other stuff (like set showcmd) because it affects
" various other options.
set nocompatible
" Load vim-pathogen
filetype off
call pathogen#runtime_append_all_bundles()
" TODO: Figure out how to keep plugin tags files cleanly out of Git.
"call pathogen#helptags()

if filereadable(expand("$VIMHOME/config.vim"))
  source $VIMHOME/config.vim
else
  redraw
  echomsg "Vim Config Error: Could not load config.vim. Did you copy config.dist.vim to config.vim?"
endif

"------------
" AESTHETICS
"------------
" Let Vim know the terminal can handle 256 colors
set t_Co=256

" Set the color scheme
colorscheme lucius

" Set the font
set guifont=Monospace\ 9

" Make command line two lines high
set ch=2

" Set the status line the way I like it
set stl=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]\ %=%{fugitive#statusline()}

" Always put a status line in, even if there is only one window
set laststatus=2

" Clean up the GUI in Gvim
if has("gui_running")
  set guioptions-=T
  set guioptions-=m
endif

" Cool trick to show what you're replacing/changing
set cpoptions+=$

" Allow the cursor to go into 'invalid' places
set virtualedit=all

" Show line numbers
set number

" Highlight the current line
set cursorline

" This shows you what you're doing in a multi-stroke command
set showcmd

"--------------
" Coding Style
"--------------
set expandtab
set textwidth=80
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
syntax on
filetype plugin on
filetype plugin indent on

if g:showColumnMarker > 0
  if exists('+colorcolumn')
    set colorcolumn=g:columnMarkerCount
  endif
endif

"--------------
" PHP-Specific
"--------------
autocmd BufNewFile,BufRead *.phtml set ft=php
" My awesome PHP syntax checking stuff:
autocmd BufNewFile,BufRead,BufWritePost *.php,*.phtml execute 'call PHPsynCHK()'
set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l
function HighlightBadPhp(...)
    echo ''
    if(exists('a:1'))
        let qflist=a:1
    else
       let qflist=getqflist()
   endif 
    let has_valid_error = 0
    for error in qflist
        if error['valid']
            let has_valid_error = 1
            break
        endif
    endfor
    if has_valid_error
        " Error found
        let linecontent=getline(error.lnum)
        if error.text =~ 'unexpected \$end$'
            let linenum=error.lnum-1
        elseif error.text =~ 'unexpected T_FUNCTION' && linecontent =~ '^\s*function\s.*'
            let linenum=error.lnum-1
        elseif error.text =~ 'unexpected T_CLASS' && linecontent =~ '^\s*class\s.*'
            let linenum=error.lnum-1
        else
            let linenum=error.lnum
        endif
        execute 'match SpellBad /\%'.linenum.'l\V\^'.escape(getline(linenum), '\').'\$/'
        call cursor(linenum,col('.'))
    else
        " No errors found, clear highlighting
        execute 'match'
    endif
endfunction
au QuickFixCmdPost make call HighlightBadPhp()
if !exists('*PHPsynCHK')
  function! PHPsynCHK()
    ccl " close quickfix window
    let winnum = winnr() " get current window number
    let linenum = line('.')
    let colnum = col('.')
    let tmpfile = tempname()
    " This will override the buffer with the php 
    silent execute "%!php -l -f /dev/stdin | sed 's/\\/dev\\/stdin/".bufname("%")."/g' | grep 'syntax error' >".tmpfile."; cat"
    silent execute "silent cf ".tmpfile
    cw " open the quickfix window if it has an error
    execute winnum . "wincmd w"
    silent undo
    silent cf
    let qflist=getqflist()
    if 1 == len(qflist)
      call cursor(linenum, colnum)
    endif
    call HighlightBadPhp(qflist)
  endfunction
endif
noremap <leader>l :execute 'call PHPsynCHK()'<CR>

"---------------
" MISC SETTINGS
"---------------
" Turn off backup stuff
set nobackup
set nowb
set noswapfile

" Shortcut for arbitrary git commands
autocmd VimEnter * Alias git Git

" Incremental search?
set incsearch

" Case-insensitive search by default
set ignorecase
set smartcase

" Fast redraw
set ttyfast

" Allow buffers to have unsaved changes
set hidden

" Bash-like tab completion for command mode
set wildmode=list:longest,full
set wildmenu

" Allow mouse support in terminal Vim
set mouse=a
" If we have any issues with mouse support in screen, try this:
"termcapinfo linux|xterm|screen* ti@:te@:XT

" Disable the stupid blinking cursor
:set guicursor+=a:blinkon0

" Disable middle-click paste (causes too many accidents with crappy mice)
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>

"------------------
" MiniBufExplorer
"------------------
" make tabs show complete (no broken on two lines)
let g:miniBufExplTabWrap = 1

" If you would like to single click on tabs rather than double clicking on them to goto the selected buffer.
let g:miniBufExplUseSingleClick = 1

" <max lines: defualt 0> setting this to 0 will mean the window gets as big as needed to fit all your buffers.
let g:miniBufExplMaxSize = 3

" Do not allow files to accidentally get opened in the NERDTree or other
" non-modifiable buffers.
let g:miniBufExplModSelTarget = 1

" Shortcuts for switching tabs/buffers
map <C-p> :bprev<CR>
map <C-n> :bnext<CR>
let g:miniBufExplMapCTabSwitchBufs = 1

" Shortcut to close tab/buffer
map <leader>q :BW<CR>

" Shortcut to re-open last closed tab
map <leader>t :BUNDO<CR>

" Confirm when closing unsaved tab
let g:BufKillActionWhenModifiedFileToBeKilled = 'confirm'

"--------------------------
" NERDTree Plugin Settings
"--------------------------
" Toggle the NERD Tree on an off with F6 in normal or insert mode
inoremap <F6> <ESC>:NERDTreeToggle<CR><C-w>li
map <F6> :NERDTreeToggle<CR><C-w>l:<ESC>

" Set the default directory for NERDTree
autocmd VimEnter * execute "cd" fnameescape(g:startDir)

" Enable NERDTree
if g:openTreeOnStart > 0
    autocmd VimEnter * NERDTree
endif

" Focus the editor buffer
autocmd VimEnter * wincmd p

let g:NERDTreeMinimalUI=1

"------------------
" CUSTOM SHORTCUTS
"------------------
" Save file shortcut
map <leader>w :w!<CR>

" Edit .vimrc shortcut.
map <leader>e :e ~/.vim/.vimrc<CR>

" Easy copy and paste
map <leader>v		"+gP
map <leader>c		"+y

" Select all text
map <C-a> ggVG

" Zen Coding expansion shortcut
let g:user_zen_expandabbr_key = '<C-z>'

inoremap <C-d> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-d> :call PhpDocSingle()<CR>
vnoremap <C-d> :call PhpDocRange()<CR>

" Sudo save (requires you to comment the 'Defaults   requiretty' line in
" /etc/suoders
ca w!! w !sudo tee "%" > /dev/null
map <leader>sw :w!!<CR>

" Allow users to cleanly override anything they want
if filereadable(expand("$VIMHOME/override.vim"))
  source $VIMHOME/override.vim
endif

"------------------------
" Auto-Completion Options
"------------------------
" Tab for auto-complete
let g:SuperTabDefaultCompletionType = '<C-x><C-o>'

" This makes auto-completion only insert the longest common text among all
" matches in the list (like bash).
set completeopt=longest,menuone,preview

" Automatically hide the preview panel
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif 
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Esc to cancel auto-competion, but not leave insert mode
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
