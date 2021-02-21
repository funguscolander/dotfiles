" C-Fergus' .vimrc

""""""""""""""""""""""""""""
" Compatibility & Security "
""""""""""""""""""""""""""""
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

"" Secure temporary files location
" move temporary files to a secure location to protect against CVE-2017-1000382
if exists('$XDG_CACHE_HOME')
  let &g:directory=$XDG_CACHE_HOME
else
  let &g:directory=$HOME . '/.vim/.cache'
endif

"" Put all Vim undo, backup, and swap files in a single directory
let &g:undodir=&g:directory . '/vim/undo//'
let &g:backupdir=&g:directory . '/vim/backup//'
let &g:directory.='/vim/swap//'

" Create the directories if they doesn't exist
if ! isdirectory(expand(&g:directory))
  silent! call mkdir(expand(&g:directory), 'p', 0700)
endif
if ! isdirectory(expand(&g:backupdir))
  silent! call mkdir(expand(&g:backupdir), 'p', 0700)
endif
if ! isdirectory(expand(&g:undodir))
  silent! call mkdir(expand(&g:undodir), 'p', 0700)
endif

"" Don't Wake the System With Blinking Cursor
let &guicursor = &guicursor . ",a:blinkon0"

"" No Language Remap
" prevent the langmap option from applying to characters that result from a mapping. if set (default), this may break plugins (but it's backward compatible).
if has('langmap') && exists('+langremap')
  set nolangremap
endif

"" No Octal in Maths
" do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it confusing
set nrformats-=octal

"" Win32 GUI No Menu Tearoff Entries
if has('win32')
  set guioptions-=t
endif

"" Enable filetype detection
" filetype enables filetype detection
" plugin enables ftplugin per-filetype vim settings
" indent enables per-filetype indentation rules
if has('autocmd')
  filetype plugin indent on
endif


"""""""""""
" Plugins "
"""""""""""

"let g:EasyMotion_leader_key = ';'



"""""""""""""""""""""""""
" General Configuration "
"""""""""""""""""""""""""

"" Commands & Keycodes
set history=9001        " keep over 9000 lines of command line history
set noesckeys           " no delay using `<Esc>` to exit insert mode
set showcmd             " show incomplete commands
set ttimeout            " timeout for key codes
set ttimeoutlen=100     " wait up to 100 ms after final key of keycode if there are logner keycodes which match what has been pressed so far
set wildmenu            " display completion matches in status line
set wildignorecase      " ignore case in wildmenu search
set wildmode=list:longest,full  " first tab shows list of completions with the longest one being completed, second tab opens the full wildmenu with all previously shown completions


"" Display
set colorcolumn=+1      " background highlight the first column after textwidth
set display+=lastline    " as much as possible of the last line in a window will be displayed. "@@@" is put in the last columns of the line to indicate the rest of the line is not displayed.
set number              " show line numbers on the left of the screen
set relativenumber      " show relative distance of line to current line on the left of the screen. current line still displays absolute number in combination with `:number`
set ruler               " show the cursor position all the time
set scrolloff=5         " keep 5 lines of context between the cursor and the edge of the screen
set sidescrolloff=5     " keep 5 characters of context between the cursor and the edge of the screen
set showmatch           " show matching brackets

" change cursor style depending on mode
let &t_EI = "\<Esc>[2 q"  " normal mode 1 is blinking box, 2 is non-blinking
let &t_SR = "\<Esc>[3 q"  " reaplce mode 3 is blinking underline, 4 is non-blinking
let &t_SI = "\<Esc>[5 q"  " insert mode 5 is blinking line

" when the terminal has colors or when using the GUI (which always has colors) and when compiled with syntax
if &t_Co > 2 || has("gui_running") && has('syntax') && !exists('g:syntax_on')
  syntax enable         " enable syntax highlighting
  set hlsearch          " switch on highlighting the last used search patter
endif


"" Editing
set autoread            " re-read files changed outside of vim but not changed in vim
set autowrite           " save before commands like :next and :make are run
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set encoding=utf-8      " recommended enconding format, though can create differences between GUI and terminal vim
set formatoptions-=t    " wrap text at textwidth without inserting a line break
set hidden              " hides a buffer when abandoned instead of unloading them
"set textwidth=80        " max textwidth, a longer line will be broken after white space to get this width
set updatetime=100      " write to swap file after 100 ms of inactivity (default 4000)

if has('reltime')
  set incsearch         " do incremental searching when it's possible to timeout.
endif


"" GVim
if has("gui_running")
  set guioptions -=r      " remove left scrollbar
  set guioptions -=L      " remove right scrollbar
endif

if has ("autocmd")
  au GUIEnter * simalt ~x " open gvim in fullscreen
endif


"" Indentation
set autoindent          " copy indent from current line when starting a new line
set smartindent         " insert an indent after `{`
set expandtab           " use spaces instead of the tab character
set softtabstop=4       " number of characters upon tab press
set shiftwidth=4        " each `>>` indents a line by 4 characters
set tabstop=4           " number of characters taken up by a tab character
set smarttab            " add and remove tabs when you `<TAB>` and`<BP>`
"set complete


"" Search
set ignorecase          " ignore case in patterns
set smartcase           " unignore case when capital letters are used


"" Windows
set splitbelow          " place new window in a horizontal split below the current window
set splitright          " place new window in a vertical split to the right of the current window



"""""""""""
" Plugins "
"""""""""""

"" Match It
" makes the % command work better
" the ! means the package won't be loaded right away, but when plugins are loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

"" NERDTree
" set file suffixes to ignore and not ignore
set suffixes+=.aux,.bbl,.blg,.brf,.cb,.dvi,.idx,.ilg,.ind,.inx,.toc
set suffixes-=.h
set suffixes-=.obj



"""""""""""""""""""""
" Remaps & Commands "
"""""""""""""""""""""

"" AutoCMD functions
" will only be enabled when compiled with support for autocommands
if has ("autocmd")
  "" Locate cursor when typing
  " highlight column and row of cursor when in insert mode
  "augroup InsertLocateCursor
  "  autocmd!
  "  autocmd InsertEnter * set cursorline cursorcolumn
  "  autocmd InsertLeave * set nocursorline nocursorcolumn
  "augroup END

  "" Vertically centre cursor
  " https://vim.fandom.com/wiki/Keep_your_cursor_centered_vertically_on_the_screen/
  " toggle keep 5 lines of context between cursor and edge of screen, and vertically centering cursor with `\vcc`
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

"" Filetype configuration
" https://stackoverflow.com/a/52156757/13734567
" open the current file's filetype configuration
nnoremap <leader>ef :e ~/.vim/after/ftplugin/<C-R>=&filetype<CR>.vim<CR>
com! EditFTP execute 'e ~/.vim/after/ftplugin/' . &filetype . 'vim'

"" Fold toggle upon `<Space>`
" toggles folding if current line is foldable,
" otherwise move right one character (default action)
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\Space")<CR>
vnoremap <Space> zf

"" Leader
"let mapleader = "\"           " leader key for global mappings
"let maplocalleader = "/"      " leader key for file/language specific mappings

"" Open newlines
" open new lines above and below without entering insert mode while staying on the same line
noremap <leader>o o<Esc>k
noremap <leader>O O<Esc>j



""""""""""""""""""""""""
" Background Functions "
""""""""""""""""""""""""

"" AutoCMD functions
" will only be enabled when compiled with support for autocommands
if has ("autocmd")
  "" Ignore case in command line
  " https://vi.stackexchange.com/a/16511/33559
  " disable `smartcase` when typing commands so tab completions always ignore case
  " assumes `set ignorecase smartcase`
  augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CMDLineleave : set smartcase
  augroup END
  
  "" Jump to last known cursor position on file load
  " when editing a file, always jump to the last known cursor position
  " don't do it when the position is invalid, when inside an event handler (happens when dropping a file on gvim),
  " and for a commit message (it's likely a different one than last time)
  augroup LastKnownPosition
    autocmd!
    autocmd BufReadPost *
          \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
          \ |   exe "normal! g`\""
          \ | endif
  augroup END
endif

