" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ADDED BY ME
set softtabstop=2
set shiftwidth=2
set tabstop=2
set autoindent
set number
set bg=light
" Set certain options if a gui is running
" &term =~ "xterm-256"
if has("gui_running")
  set guifont=Menlo\ Regular:h14
  set guioptions+=TlLb
  set guioptions-=TlLb
  set lines=60
  set columns=120
endif
colorscheme solarized
set hidden
set ignorecase
set vb " turns off visual bell
set expandtab
set smartindent
set laststatus=2
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " filename
set statusline+=%h%m%r%w                     " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=\ %{fugitive#statusline()}     " fugitive
set statusline+=%=                           " right align remainder
set statusline+=0x%-8B                       " character value
set statusline+=%-14(%l,%c%V%)               " line, character
set statusline+=%<%P                         " file position

match NonText /\s\s*$/

compiler ruby

autocmd FileType make     set noexpandtab
autocmd FileType python   set noexpandtab
autocmd FileType mkd      let b:surround_42 = "**\r**"
autocmd FileType mkd      let b:surround_95 = "__\r__"

let mapleader=","

let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Process_File_Always=1
let Tlist_Show_Menu=1
let Tlist_Enable_Fold_Column=0
let g:gist_detect_filetype = 1
let g:LustyJugglerSuppressRubyWarning = 1
let g:speckyWindowType = 1
let g:speckyRunSpecCmd = "spec -cbfs"
let g:speckyRunSpecKey = "<leader>r"
let g:speckySpecSwitcherKey = "<leader>x"

set grepprg=ack
set grepformat=%f:%l:%m

map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
map <leader>f :Ack<Space>
map <leader>ws :%s/\s\+$//<CR>
map <Leader>s <Plug>Vsurround
map <Leader>S <Plug>Vsurround
map <Leader>om :call PreviewMKD()<CR>
map <Leader>cz :new<CR>:ConqueTerm zsh<CR>
map <Leader>cx :tab new<CR>:ConqueTerm zsh<CR>

function! ToggleScratch()
  if expand('%') == g:ScratchBufferName
    quit
  else
    Sscratch
  endif
endfunction

map <leader>ts :call ToggleScratch()<CR>
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backupdir=~/.vimswaps,/tmp
set directory=~/.vimswaps,/tmp

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
"set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " Settings for raw text editing
  autocmd BufRead *\.txt setlocal formatoptions=l
  autocmd BufRead *\.txt setlocal lbr
  autocmd BufRead *\.txt map j gj
  autocmd BufRead *\.txt map k gk
  autocmd BufRead *\.txt setlocal smartindent
  autocmd BufRead *\.txt setlocal spell spelllang=en_us

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

  augroup mkd

    autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")
