"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme first!
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme forest-night

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Package manager and packages
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable minpac, if it is installed
packadd minpac
if exists('*minpac#init')
	" minpac is available
	call minpac#init()

	call minpac#add('k-takata/minpac', {'type':'opt'})
	call minpac#add('vim-airline/vim-airline')
	call minpac#add('vim-airline/vim-airline-themes')
	call minpac#add('prabirshrestha/async.vim')
	call minpac#add('prabirshrestha/asyncomplete.vim')
	call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
	call minpac#add('prabirshrestha/vim-lsp')

	if executable('rustc')
		call minpac#add('rust-lang/rust.vim')
	endif

	if executable('git')
		call minpac#update()
	endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Layout and display
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Configure air line. No impact if it's not installed
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

"Display all matching files when we tab-complete
set wildmenu

" Put a ruler at column 100
set colorcolumn=100

" set to abosulte numbering with relative numbers on top. CTRL-n toggles
set number
set relativenumber

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
set t_Co=256


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
set foldnestmax=2
set nofoldenable
set foldlevel=1

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
inoremap kj <Esc>
cnoremap kj <C-C>

command! MakeTags !ctags -R .

if executable('cargo')
	" Set up for rust, if cargo is present
	nnoremap <Leader>mc :make check <CR>
	nnoremap <Leader>mt :make test <CR>

	command! Fmt !cargo fmt
	command! Clean !cargo clean
else
	nnoremap <Leader>m :make <CR>
endif

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
