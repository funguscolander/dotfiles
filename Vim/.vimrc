" C-Fergus' .vimrc {{{
" vim: set foldmethod=marker foldlevel=0 :
" }}}

" Compatibility & Security {{{
""""""""""""""""""""""""""""""

"" Vi compatibility
" use Vim settings, rather than Vi settings.
" this must be first, because it changes other options as a side effect.
" avoid side-effects when nocompatible has already been set.
if &compatible
  set nocompatible
endif

" when the +eval feature is missing, the set command above will be skipped.
" use a trick to reset compatible only when the +eval feature is missing.
silent! while 0
  set nocompatible
silent! endwhile


"" Don't wake the system with blinking cursor
let &guicursor = &guicursor . ",a:blinkon0"


"" Enable Alt (Meta) key combinations in terminal
" https://vim.fandom.com/wiki/Fix_meta-keys_that_break_out_of_insert_mode
" the terminal keycode for the meta key is the same as the escape key, this remaps <M-{a to z}> so it can be used
let metaRemapChar='a'
while metaRemapChar <= 'z'
  exec "set <M-".toupper(metaRemapChar).">=\e".metaRemapChar
  exec "imap \e".metaRemapChar." <M-".toupper(metaRemapChar).">"
  let metaRemapChar = nr2char(1 + char2nr(metaRemapChar))
endw


"" Enable filetype detection
" filetype enables filetype detection
" plugin enables ftplugin per-filetype vim settings
" indent enables per-filetype indentation rules
if has('autocmd')
  filetype off
  filetype plugin indent on
endif


"" No Language Remap
" prevent the langmap option from applying to characters that result from a mapping. if set (default), this may break plugins (but it's backward compatible).
if has('langmap') && exists('+langremap')
  set nolangremap
endif


"" No Octal in Maths
" do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it confusing
set nrformats-=octal


"" Secure temporary files location
" move swap files to a secure location to protect against CVE-2017-1000382
if exists('$XDG_CACHE_HOME')
  let &g:directory=$XDG_CACHE_HOME
else
  let &g:directory=$HOME . '/.cache/vim'
endif

" put all Vim undo, backup, and swap files in a single directory
let &g:undodir=&g:directory . '/undo//'
let &g:backupdir=&g:directory . '/backup//'

" create the directories if they doesn't exist
if ! isdirectory(expand(&g:directory))
  silent! call mkdir(expand(&g:directory), 'p', 0700)
endif
if ! isdirectory(expand(&g:backupdir))
  silent! call mkdir(expand(&g:backupdir), 'p', 0700)
endif
if ! isdirectory(expand(&g:undodir))
  silent! call mkdir(expand(&g:undodir), 'p', 0700)
endif


"" Win32 GUI No Menu Tearoff Entries
if has('win32')
  set guioptions-=t
endif


" }}}
" General Configuration {{{
"""""""""""""""""""""""""""

"" Commands & Keycodes
set history=9001        " keep over 9000 lines of command line history
"set noesckeys           " no delay using `<Esc>` to exit insert mode (only 10ms w/ arrow keys with 3 commands below)
set notimeout           " do not timeout on :mappings
set ttimeout            " timeout on key codes
set ttimeoutlen=10      " wait 10 ms before sending matched keycode if there are longer codes with the same beginning
set showcmd             " show incomplete commands
set wildmenu            " display completion matches in status line
set wildignorecase      " ignore case in wildmenu search
set wildmode=list:longest,full  " first tab shows list of completions with the longest one being completed, second tab opens the full wildmenu with all previously shown completions


"" Display
set colorcolumn=+1      " background highlight the first column after textwidth
set display+=lastline    " as much as possible of the last line in a window will be displayed. "@@@" is put in the last columns of the line to indicate the rest of the line is not displayed.
exec "set listchars=eol:¬"
set number              " show line numbers on the left of the screen
set relativenumber      " show relative distance of line to current line on the left of the screen. current line still displays absolute number in combination with `:number`
set ruler               " show the cursor position all the time
set scrolloff=5         " keep n lines of context between the cursor and the edge of the screen
set sidescrolloff=5     " keep n characters of context between the cursor and the edge of the screen
set showmatch           " show matching brackets
set showmode            " put a `INSERT`, `REPLACE`, or `VISUAL` on the last line
set whichwrap=b,s,<,>   " at the beginning and end of a line, move up and down with BKSP & <, and ENTER & >
set wrap                " visually wrap lines longer than the width of the screen
set linebreak           " use with `wrap`: break lines at word boundaries (see `breakat`) instead of last character
set breakindent         " Every wrapped line will continue visually indented (same amount of space as the beginning of that line), thus preserving horizontal blocks of text

" change cursor style depending on mode in VTE terminals
" https://vim.fandome.com/wiki/Change_cursor_shape_in_different_modes
let &t_EI = "\<esc>[1 q"  " normal mode 1 is blinking box, 2 is non-blinking
let &t_SR = "\<esc>[3 q"  " replace mode 3 is blinking underline, 4 is non-blinking
let &t_SI = "\<esc>[5 q"  " insert mode 5 is blinking line

" when the terminal has colors or when using the GUI (which always has colors) and when compiled with syntax
if &t_Co > 2 || has("gui_running") && has('syntax') && !exists('g:syntax_on')
  syntax enable         " enable syntax highlighting
  set hlsearch          " switch on highlighting the last used search patter
endif


"" Editing
set autoread            " re-read files changed outside of vim but not changed in vim
set autowrite           " save before commands like :next and :make are run
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set complete=.,w,b,u,t  " what is this. enable insert mode variable autocomplete: `<C-P>` forward, `<C-N>` backward; and
" scan only all loaded and unloaded buffers for autocomplete
set completeopt=longest,menuone " complete longest common match, always display menu, use <C-L> to add more characters
" TODO: Look more at `completeopt`, there are other good options
set encoding=utf-8      " recommended enconding format, though can create differences between GUI and terminal vim
set hidden              " hides a buffer when abandoned instead of unloading them
set modeline            " use modeline
set shortmess+=r        " use "[RO]" instead of "[readonly]" on the statusline
set nostartofline       " stay on current column, don't jump to SoL on some commands
set textwidth=0         " max textwidth, a longer line will be broken after white space to get this width
set undofile            " enable undo tree caching of all files to `undodir`
set undolevels=1000     " max number of changes that can be undone (default: 100)
set undoreload=10000    " max number of lines where the whole buffer can be saved to memory for undo when reloading
set updatetime=100      " write to swap file after 100 ms of inactivity (default 4000)
set virtualedit=block   " allow the cursor to be positioned where there is no actual character in visual block mode

" formatoptions:
" t: wrap text at `textwidth`
" c: wrap comments at `textwidth`, inserting comment leader on the newline
" r: insert comment leader after hitting <Enter> in insert mode
" n: recognise numbered lists when formatting with `auto-indent`
" j: remove comment leader when joining comment lines
" 1: don't break lines after a one-letter word, break before instead
set formatoptions=cqrnj1 


"" File
set backup              " use file backups
set fileformats=unix,dos,mac  " prefer `\<NL>` (Unix) over just `\<CR>\<NL>` (Windows) over just `\<CR>` (macOS)
let g:tex_flavor = 'latex'    " assume all `.tex` files are LaTeX

" set filetype of files without an identifying shebang or extension
autocmd BufNewFile,BufRead .*aliases set filetype=sh


"" GVim
if has("gui_running")
  set guioptions -=r    " remove left scrollbar
  set guioptions -=L    " remove right scrollbar
endif

if has ("autocmd")
  au GUIEnter * simalt ~x " open gvim in fullscreen
endif


"" Indentation
set autoindent          " copy indent from current line when starting a new line
set smartindent         " insert an indent after `{`
set expandtab           " use spaces instead of the tab character
set softtabstop=2       " number of characters upon tab press
set shiftwidth=2        " each `>>` indents a line by 4 characters
set tabstop=2           " number of characters taken up by a tab character
set shiftround          " round indent to multiple of `shiftwidth`
set smarttab            " add and remove tabs when you `<TAB>` and`<BP>`


"" Search
set ignorecase          " ignore case in patterns
set smartcase           " unignore case when capital letters are used
set maxmempattern=5120  " max memory used for pattern matching

if has('reltime')
  set incsearch         " do incremental searching when it's possible to timeout.
endif

" set file suffixes to ignore and not ignore in file autocompletion
set suffixes+=.aux,.bbl,.blg,.brf,.cb,.dvi,.idx,.ilg,.ind,.inx,.toc
set suffixes-=.h
set suffixes-=.obj


"" Window
set splitbelow          " place new window in a horizontal split below the current window
set splitright          " place new window in a vertical split to the right of the current window


" }}}
" Plugins {{{
""""""""""""" 

"" Color scheme
if $COLORTERM ==# 'kmscon'
  " compatibility stuff if it doesn't show correctly
  " see `:h xterm-true-color` for the details
  " https://github.com/vim/vim/issues/993#issuecomment-255651605
  let &t_8f = "\<esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<esc>[48;2;%lu;%lu;%lum"
  set termguicolors

  augroup KMSCONEntryRedraw
    autocmd!
    autocmd VimEnter,VimResized,VimResume *
          \ :redraw!
  augroup END
elseif $TERM ==# 'fbterm'
elseif $TERM ==# 'linux'
elseif $TERM ==# 'xterm-256color'
endif

set background=dark

" Gruvbox
"colorscheme gruvbox

" Solarized8
"colorscheme solarized8_high     " high-contrast variant
"colorscheme solarized8          " default Solarized theme
"colorscheme solarized8_low      " low-contrast variant
"colorscheme solarized8_flat     " 'flat' variant, not Solarized origin, different statusline and split/tab bars


"" EasyAlign
" start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" start interactive EasyAlign in visual mode (e.g. vipga)
vmap ga <Plug>(EasyAlign)


"" EasyMotion
"let g:EasyMotion_leader_key = ';'


"" Match It
" makes the % command work better
" the ! means the package won't be loaded right away, but when plugins are loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
set matchpairs+=<:>           " also allow < and > as match pairs using `%`
if has ("autocmd")
  autocmd FileType c,cpp,java set mps+==:; " jump between the = and ; in an assignment
endif


"" Vim-Leader-Guide
"hi def link LeaderGuideFloating Normal
"let g:lmap = {}         " define prefix dictionary, added mappings will show up when the leader key is pressed
"let g:leaderGuide_vertical = 1          " list mappings vertically
"let g:leaderGuide_position = 'botleft'  " place popup at bottom left of screen
"let g:lmap.z = 'V Centre'
"
"" register the dictionary:
"call leaderGuide#register_prefix_descriptions("\\", "g:lmap")
"nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
"vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>


"" Vim-Which-Key
"noremap <silent> <leader> :<c-u>WhichKey '\'<CR>

" "" VimWiki
" let g:vimwiki_global_ext = 0  " only files in the wiki directories are treated as vimwiki files
" let g:vimwiki_ext2syntax = {'.md': 'markdown',
"       \ '.mkdn': 'markdown',
"       \ '.mdwn': 'markdown',
"       \ '.mdown': 'markdown',
"       \ '.markdown': 'markdown',
"       \ '.mw': 'media',
"       \ '.rmd': 'markdown',
"       \ '.Rmd': 'markdown'}


"" Wiki.Vim
" define wiki location and make the directory if it doesn't exist
let g:wiki_root=$HOME . '/Documents/notes'

if ! isdirectory(expand(g:wiki_root))
  silent! call mkdir(expand(g:wiki_root), 'p', 0700)
endif

" only files in wiki directories are treated as wiki files
let g:wiki_global_load=0
" filetypes for which wiki.vim should be enabled
let g:wiki_filetypes= ['rmd', 'md', 'wiki']
" file extension applied to wiki links
let g:wiki_link_extension='.rmd'
" set default link style to markdown
let g:wiki_link_target_type='md'
" save current file before navigating away through wiki links
let g:wiki_write_on_nav=1





" }}}
" Remaps & Commands {{{
"""""""""""""""""""""""

"" AutoCMD functions
" will only be enabled when compiled with support for autocommands
if has ("autocmd")
  "" Vertically centre cursor
  " https://vim.fandom.com/wiki/Keep_your_cursor_centered_vertically_on_the_screen/
  " toggle `scrolloff` lines of context between cursor and edge of screen, and vertically centering cursor with `\zz`
  " `\zz` is used because `zz` vertically centres the screen on the cursor line
  if !exists('*VCenterCursor')
    augroup VCenterCursor
      au!
      au OptionSet *,*.*
            \ if and( expand("<amatch>")=='scrolloff' ,
            \         exists('#VCenterCursor#WinEnter,WinNew,VimResized') )|
            \   au! VCenterCursor WinEnter,WinNew,VimResized|
            \ endif
    augroup END
    function VCenterCursor()
      if !exists('#VCenterCursor#WinEnter,WinNew,VimResized')
        let s:default_scrolloff=&scrolloff
        let &scrolloff=winheight(win_getid())/2
        au VCenterCursor WinEnter,WinNew,VimResized *,*.*
              \ let &scrolloff=winheight(win_getid())/2
      else
        au! VCenterCursor WinEnter,WinNew,VimResized
        let &scrolloff=s:default_scrolloff
      endif
    endfunction
  endif
endif

nnoremap <leader>zz :call VCenterCursor()<CR>


"" Change text motion extended bounding items (*nixcasts)
let motionItems = [ "<bar>", "\\", "/", ":", ".", "*", "_" ]
for item in motionItems
  exe "nnoremap yi".item." T".item."yt".item
  exe "nnoremap ya".item." F".item."yf".item
  exe "nnoremap ci".item." T".item."ct".item
  exe "nnoremap ca".item." F".item."cf".item
  exe "nnoremap di".item." T".item."dt".item
  exe "nnoremap da".item." F".item."df".item
  exe "nnoremap vi".item." T".item."vt".item
  exe "nnoremap va".item." F".item."vf".item
endfor


"" Complete menu navigation and selection with arrow keys and `<Enter>`
" navigate the complete menu items like CTRL+n / CTRL+p would.
inoremap <expr> <Down> pumvisible() ? "<C-n>" :"<Down>"
inoremap <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"

" select the complete menu item like CTRL+y would.
inoremap <expr> <Right> pumvisible() ? "<C-y>" : "<Right>"
inoremap <expr> <CR> pumvisible() ? "<C-y>" :"<CR>"

" cancel the complete menu item like CTRL+e would.
inoremap <expr> <Left> pumvisible() ? "<C-e>" : "<Left>"


"" CTRL-U but undoable friendly
" <CTRL-U> in insert mode deletes a lot. use <CTRL-G> u to first break undo, so that you can undo <CTRL-U> after inserting a line break
inoremap <C-U> <C-G>u<C-U>

"" Diff original and edited file
" https://vimdoc.sourceforge.net/htmldoc/diff.html#:DiffOrig
" see the difference between the current buffer and the file it was loaded from, thus the changes you made.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

"" Edit configuration files
" https://stackoverflow.com/a/52156757/13734567
" vimrc
nnoremap <leader>ev :e $MYVIMRC<CR>
" current file's filetype configuration
nnoremap <leader>ef :e ~/.vim/after/ftplugin/<C-R>=&filetype<CR>.vim<CR>
command! EditFTP execute 'e ~/.vim/after/ftplugin/' . &filetype . 'vim'

"" Fold toggle upon `\`
" toggles folding if current line is foldable,
" otherwise move right one character (default action)
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

"" Increment and decrement on other lines
" https://vim.fandom.com/wiki/Increasing_or_decreasing_numbers
" dependencies: `tpope/vim-repeat`
" <C-a> and <C-x> now search for the next number on other lines as well instead of just the current
" <leader> <C-a> and <leader> <C-b> search backwards instead
function! IncrementDecrement(char, back)
  let pattern = &nrformats =~ 'alpha' ? '[[:alpha:][:digit:]]' : '[[:digit:]]'
  call search(pattern, 'cw' . a:back)
  execute 'normal! ' . v:count1 . a:char
  silent! call repeat#set(":\<C-u>call IncrementDecrement('" .a:char. "', ," .a:back. "')\<CR>")
endfunction
nnoremap <silent>         <C-a> :<C-u>call IncrementDecrement("\<C-a>", '')<CR>
nnoremap <silent> <leader><C-a> :<C-u>call IncrementDecrement("\<C-a>", 'b')<CR>
nnoremap <silent>         <C-x> :<C-u>call IncrementDecrement("\<C-x>", '')<CR>
nnoremap <silent> <leader><C-x> :<C-u>call IncrementDecrement("\<C-x>", 'b')<CR>

" Keep cursor at the bottom of the visual selection after you yank it.
vmap y ygv<Esc>

"" Leader
" backslash and slash are the default leader and localleader respectively
"noremap <Space> <Nop>
"let g:mapleader = "\<Space>"    " leader key for global mappings
"let g:maplocalleader = "/"      " leader key for file/language specific mappings

"" Line number and relative number
nnoremap <leader>nn :set number! relativenumber!<CR>

"" Navigate around splits in normal mode with <C-hjkl>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>

"" Navigate in insert mode with <C-hjkl>
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>gj
inoremap <C-k> <C-o>gk
inoremap <C-l> <C-o>l

"" Open newlines
" open new lines above and below without entering insert mode while staying on the same line
noremap <leader>o o<Esc>k
noremap <leader>O O<Esc>j

"" Prevent selecting and pasting from overwriting what you originally copied.
xnoremap p pgvy

"" Prevent `x` from overwriting the clipboard
noremap x "_x
noremap X "_x

"" Remove search highlighting
nnoremap <leader>h :nohlsearch<CR>

"" Replace all instances of highlighted term in current file
" press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

"" Seamlessly treat visual lines as actual lines when moving around.
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up> gk

"" Search for current word in other splits
" based on: https://superuser.com/a/80381/1185996
" <Leader>* is * (next word) in other panel
" <Leader># is next WORD in other panel, not # (prev word) in other panel
nnoremap <Leader>* :let @/=expand("<cword>")<Bar>wincmd w<Bar>normal Gn<CR>:wincmd w<CR>
nnoremap <Leader># :let @/=expand("<cWORD>")<Bar>wincmd w<Bar>normal Gn<CR>:wincmd w<CR>

"" Split resizing
" meta + direction to resize the current split
" TODO: <M-hjkl> resizing doesn't work :(
nnoremap <M-h> <C-W><
nnoremap <M-j> <C-W>-
nnoremap <M-k> <C-W>=
nnoremap <M-l> <C-W>>


"" Yank (capital) like capital delete (`D`) and capital change (`C`)
nnoremap Y y$


" }}}
" Background Functions {{{
"""""""""""""""""""""""""" 

"" AutoCMD functions
" will only be enabled when compiled with support for autocommands
if has ("autocmd")
  "" Command window
  " norelativenumber
  augroup cmdWin
    autocmd!
    autocmd CmdwinEnter * set norelativenumber |
  augroup END

  " "" Cursor line visible only in current split
  " augroup cursorLine
  "   autocmd!
  "   autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  "   autocmd WinLeave * setlocal nocursorline
  " augroup END

  "" Cursor line while typing
  " highlight column and row of cursor when in insert mode
  "augroup InsertLocateCursor
  "  autocmd!

  "  autocmd InsertEnter * set cursorline cursorcolumn
  "  autocmd InsertLeave * set nocursorline nocursorcolumn
  "augroup END
  
  "" Ignore case in command mode
  " https://vi.stackexchange.com/a/16511/33559
  " disable `smartcase` when typing commands so tab completions always ignore case
  " assumes `set ignorecase smartcase`
  augroup dynamicSmartcase
    autocmd!
    autocmd CmdlineEnter : set nosmartcase
    autocmd Cmdlineleave : set smartcase
  augroup END

  "" Jump to last known cursor position on file load
  " when editing a file, always jump to the last known cursor position
  " don't do it when the position is invalid, when inside an event handler (happens when dropping a file on gvim),
  " and for a commit message (it's likely a different one than last time)
  augroup lastKnownPosition
    autocmd!
    autocmd BufReadPost *
          \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' |
          \   exe "normal! g`\"" |
          \ endif
  augroup END

  "" Presentation mode less clutter and easier navigation
  autocmd BufNewFile,BufRead *.vpm call SetVimPresentationMode()
  function SetVimPresentationMode()
    nnoremap <buffer> <Right> :n<CR>
    nnoremap <buffer> <Left> :N<CR>

    if !exists('#goyo')
      Goyo
    endif
  endfunction

  "" Resize splits automatically when Vim is resized
  augroup splitResize
    autocmd!
    autocmd VimResized * wincmd =
  augroup END

  "" Source vimrc after saving
  augroup vimrcSaveSource
    autocmd!
    autocmd BufWritePost .vimrc source $HOME/.vimrc
  augroup END

  " Unset paste on InsertLeave.
  augroup unsetPaste
    autocmd!
    autocmd InsertLeave * silent! set nopaste
  augroup END

  "" Update a buffer's contents on focus if it changed outside of Vim.
  " https://vi.stackexchange.com/a/20397/33559
  augroup updateBufferContents
    autocmd!
    autocmd FocusGained,BufEnter *
          \ if getcmdwintype() == '' |
          \   checktime |
          \ endif
  augroup END
endif


" }}}

