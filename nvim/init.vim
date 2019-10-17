"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme first!
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors
set background=dark
colorscheme twilight
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Package manager and packages
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable minpac, if it is installed
packadd minpac
if exists('*minpac#init')
	" minpac is available
	call minpac#init()

	call minpac#add('k-takata/minpac', {'type':'opt'})
	call minpac#add('itchyny/lightline.vim')
	call minpac#add('prabirshrestha/async.vim')
	call minpac#add('prabirshrestha/asyncomplete.vim')
	call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
	call minpac#add('prabirshrestha/vim-lsp')
	call minpac#add('tpope/vim-fugitive')
	call minpac#add('tpope/vim-obsession')
	call minpac#add('gcmt/taboo.vim')

	if executable('rustc')
		call minpac#add('rust-lang/rust.vim')
	endif

	call minpac#update()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Options for taboo plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guioptions-=e
set sessionoptions+=tabpages,globals
let g:taboo_tab_format="  %I[%f%m]%U  "
let g:taboo_renamed_tab_format="  %I[%l%m]%U  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Layout and display
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Display all matching files when we tab-complete
set wildmenu

" Put a ruler at column 100
set colorcolumn=100

" Always show the sign column
set signcolumn=yes

" Show the status line
set laststatus=2

" set to abosulte numbering with relative numbers on top. CTRL-n toggles
set number
set relativenumber

" Get rid of -- INSERT --
set noshowmode

" Configure lightline
let g:lightline = {
		\ 'colorscheme': 'one',
		\ 'active': {
		\	'left': [ [ 'mode', 'paste'],
		\	          ['gitbranch', 'readonly', 'filename', 'modified' ]]
		\ },
		\ 'component_function' : {
		\	'gitbranch':'fugitive#head'
		\ },
		\ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File system and general system
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Search down into sub folders with tab completion using find
set path+=**

"global clipboard for copy pasting between terminals
set clipboard=unnamedplus

"enable mouse support
set mouse=a

"check file change every 4 seconds ('CursorHold') and reload the buffer upon detecting change
set autoread
au CursorHold * checktime

"to get colors working correctly.
if !has('gui_running')
	set t_Co=256
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax, code formatting, and code folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
filetype plugin indent on

"convert tabs to 4 spaces
set tabstop=4
"shift/indent also to 4 spaces
set shiftwidth=4
"auto indent (pressing enter, will indent)
set autoindent
set smartindent
set cindent

" Set up folding
set foldmethod=indent
set foldnestmax=20
set nofoldenable
set foldlevel=1

" A little something for terminal mode
if has('nvim')
	highlight! link TermCursor Cursor
	highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set up searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('rg')
	" Use Ripgrep if possible, cause it's fast!
	set grepprg=rg\ -H\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
elseif executable('git')
	set grepprg=git\ grep\ -nI
	set grepformat=%f:%l:%m
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My custom key mappings and commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = " "
nnoremap <Leader>j :cnext <CR>
nnoremap <Leader>k :cprevious <CR>
nnoremap <Leader>o :copen <CR>
nnoremap <Leader>c :cclose <CR>
nnoremap <silent> <C-n> :set relativenumber!<cr>
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
inoremap kj <Esc>
cnoremap kj <C-C>

if has('nvim')
	tnoremap kj <C-\><C-n>
	tnoremap <M-h> <C-\><C-n><C-w>h
	tnoremap <M-j> <C-\><C-n><C-w>j
	tnoremap <M-k> <C-\><C-n><C-w>k
	tnoremap <M-l> <C-\><C-n><C-w>l
	tnoremap <C-v>kj kj
endif

command! MakeTags !ctags -R .

if executable('cargo')
	" Set up for rust, if cargo is present
	nnoremap <Leader>mc :make check <CR>
	nnoremap <Leader>mt :make test <CR>

	command! Fmt !cargo fmt
	command! Clean !cargo clean
endif

nnoremap <Leader>m :make <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set up LSP clients
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('rls')
	au User lsp_setup call lsp#register_server({
		\ 'name': 'rls',
		\ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
		\ 'whitelist': ['rust'],
		\ })
endif

if executable('pyls')
	au User lsp_setup call lsp#register_server({
		\ 'name': 'pyls',
		\ 'cmd': {server_info->['pyls']},
		\ 'whitelist': ['python'],
		\})
endif

