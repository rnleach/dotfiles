" Basic Setup
set nocompatible

" Enable syntax and plugins
syntax enable
filetype plugin on

" Search down into sub folders with tab completion using find
set path+=**

"Display all matching file when we tab-complete
set wildmenu

" Create the tags file
command! MakeTags !ctags -R .

" NOW WE CAN:
" - Use ^-] to jump to tag under cursor
" - Use g^-] for ambiguous tags
" - Use ^-t jump back up the tag stack

" Put a ruler at column 100
set colorcolumn=100

" set to abosulte numbering with relative numbers on top. CTRL-n toggles
set number
set relativenumber
"CTRL-n to toggle numbers
nnoremap <silent> <C-n> :set relativenumber!<cr>

"convert tabs to 4 spaces
set tabstop=4
"shift/indent also to 4 spaces
set shiftwidth=4
"auto indent (pressing enter, will indent)
set autoindent
set smartindent
set cindent

"global clipboard for copy pasting between terminals
set clipboard=unnamedplus

"enable mouse support
set mouse=a

"check file change every 4 seconds ('CursorHold') and reload the buffer upon detecting change
set autoread
au CursorHold * checktime

"to get colors working correctly.
set t_Co=256

" Show the status line
set laststatus=2

" Set the color of the  status bar based on the mode.
function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline guibg=Yellow ctermfg=Yellow guifg=Black ctermbg=Black
  elseif a:mode == 'r'
    hi statusline guibg=Red ctermfg=Red guifg=Black ctermbg=Black
  else
    hi statusline guibg=DarkRed ctermfg=DarkRed guifg=Black ctermbg=Black
  endif
endfunction

" Call the function to set the statusbar color when changing modes.
au InsertEnter * call InsertStatuslineColor(v:insertmode)
" When leaving insert mode set the color of the status line for normal mode.
au InsertLeave * hi statusline guibg=DarkGreen ctermfg=DarkGreen guifg=White ctermbg=White

" default the statusline to green when entering Vim
hi statusline guibg=DarkGrey ctermfg=DarkGreen guifg=White ctermbg=White

" Formats the statusline
set statusline=%F%m                             " file name and modified status
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, " file encoding
set statusline+=%{&ff}]                         " file format
set statusline+=%y                              " filetype
set statusline+=%r                              " read only flag

set statusline+=\ %=                        " align right
set statusline+=Line:%l/%L[%p%%]            " line X of Y [percent of file]
set statusline+=\ Col:%c                    " current column
set statusline+=\ Buf:%n                    " Buffer number
set statusline+=\ [%b][0x%B]\               " ASCII and byte code under cursor



