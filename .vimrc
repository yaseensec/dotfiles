"{{{ Plugins
"call plug#begin('~/.config/nvim/plugged')
call plug#begin()
    Plug 'preservim/nerdtree'
    Plug 'easymotion/vim-easymotion'
    Plug 'tomasiser/vim-code-dark'
    Plug 'morhetz/gruvbox'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'
    Plug 'vimwiki/vimwiki'
    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
call plug#end()
"}}}

"General Settings {{{
let mapleader=" "                                                      "Map the leader key to space
set nocompatible
syntax enable                                                          "Enable Syntax highlighting
syntax on                                                              "Set Syntax on
filetype plugin on
filetype plugin indent on                                              "Enable Filetype Based Indentation
set autoindent                                                         "Respect Indentation When Starting New Line
set expandtab                                                          "Expand Tabs to Space.Essential in Python
set tabstop=4                                                          "Number of Spaces Tab is Counted for
set list
set shiftwidth=4                                                       "Number of Spaces to be used for Autoindent
set backspace=2                                                        "Fix Backspace Behaviour on most Terminals
set number relativenumber                                              "Sets Reltaive Line Numbers
set wildmenu                                                           "Enable enhanced tab autocomplete
set wildmode=list:longest,full                                         "Complete till longest string,then open the wildmenu
set hlsearch                                                           "Highlight every match on screen
set incsearch                                                          "Moves dynamically to first match just after typing
set foldmethod=marker                                                  "Set Folding Method based on Marker
"set foldcolumn=1                                                       "Setting the first column of vim for folds for + - |
set smartcase
set ignorecase                                                         "Automatically Switch to Case-Sensitive when using Uppercase
set clipboard+=unnamedplus                                             "Using the system clipboard for all operations instead of +&* registers
set cursorline                                                         "Sets the cursorline
set encoding=UTF-8
set splitbelow splitright
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
noremap <silent> <leader>c :let @/ = ""<CR>
"set cursorcolumn
"}}}

"Themes{{{
set termguicolors
colorscheme gruvbox
set background=dark
let g:gruvbox_invert_indent_guides=1
let g:gruvbox_contrast_dark='soft'
let g:gruvbox_italic=1
"set t_Co=256
"set t_ut=
"}}}

"Statusline{{{
"set laststatus=2
"set statusline=
"set statusline+=\ %M
"set statusline+=%#IncSearch#
"set statusline+=\ %y
"set statusline+=\ %r
"set statusline+=%#CursorLineNr#
"set statusline+=\ %F
"set statusline+=%= "Right side settings
"set statusline+=%#Search#
"set statusline+=\ %p%%
"set statusline+=\ %c:%l/%L
"set statusline+=\ [%n]
"}}}

"Swap and Undo Dir{{{
"Let's save undo info!
if !isdirectory($HOME."/.vim")                                         "Checking .vim dir present or not
     call mkdir($HOME."/.vim", "", 0770)                               "Creating .vim directory
endif
if !isdirectory($HOME."/.vim/undodir")                                 "Checking Undodir present or not
     call mkdir($HOME."/.vim/undodir", "", 0700)                       "Creating Undodir
endif
set undodir=~/.vim/undodir                                             "UndoDirectory
set undofile                                                           "Enabling Undo File
set directory=~/.vim/swap                                       "Swap Files Directory
"}}}

"Split Navigation{{{
"Fast Split Navigation with <ctrl> + hjkl
noremap <c-h> <c-W><c-h>
noremap <c-j> <c-W><c-j>
noremap <c-k> <c-W><c-k>
noremap <c-l> <c-W><c-l>
"}}}

"Plugin Settings{{{
"NerdTree
noremap <leader>n :NERDTreeToggle<cr>

"GitGutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = 'm'
let g:gitgutter_sign_removed = 'd'
let g:gitgutter_sign_removed_first_line = 'rf'
let g:gitgutter_sign_modified_removed = 'mr'
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0
let g:gitgutter_highlight_linenrs = 1
nmap ) <Plug>(GitGutterNextHunk)
nmap ( <Plug>(GitGutterPrevHunk)

"Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline_theme = 'molokai'
let g:airline_powerline_fonts = 1

"VimWiki
let g:vimwiki_list = [{'path': '~/References/vimwiki/', 'auto_diary_index': 1}]

"Goyo & Limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

"Goyo settings
noremap <leader>g :Goyo<CR>
function! s:goyo_enter()
    set noshowmode
    set noshowcmd
    set nocursorline
    "CocDisable
    Limelight
endfunction

function! s:goyo_leave()
    set showmode
    set showcmd
    set cursorline
    "CocEnable
    hi! Normal ctermbg=NONE guibg=NONE 
    hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
    Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

"FZF
nnoremap <A-g> :GFiles<CR>
nnoremap <A-z> :Files<CR>
let g:fzf_preview_window = 'right:60%'
"let g:fzf_layout = { 'down': '40%' }
command! -bang -nargs=? -complete=dir Files
     \ call fzf#vim#files(<q-args>, {'options': ['--preview', 'preview {}']}, <bang>0)
command! -bang -nargs=? -complete=dir GFiles
     \ call fzf#vim#gitfiles(<q-args>, {'options': ['--preview', 'preview {}']}, <bang>0)

"}}}

"MISC{{{
command! Bd :bp | :sp | :bn | :bd                                       "Close buffer without closing window
"packloadall                                                             "Load All Plugins
"silent! helptags ALL                                                    "Load help files for all plugins
"}}}

"Transparent Background{{{
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
"}}}

