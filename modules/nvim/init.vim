" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin(stdpath('data') . '/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'dense-analysis/ale'
Plug 'wakatime/vim-wakatime'
Plug 'rstacruz/vim-closer'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim'
Plug 'machakann/vim-sandwich'
"Plug 'ithub/copilot.vim' | It is installed via git

"Color Themes
Plug 'kyoz/purify', { 'rtp': 'vim' }
Plug 'morhetz/gruvbox'

call plug#end()

filetype plugin indent on
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=2
set autoindent
set textwidth=88
set number
colorscheme gruvbox
set clipboard=unnamedplus
set mouse=a

" BEGIN - Change cursor to bar in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
" reset the cursor on start (for older versions of vim, usually not required)
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END
set ttimeout
set ttimeoutlen=1
set ttyfast
" END - Change cursor to bar in insert mode

" Mapping to jump to next error: [c and ]c
try
  nmap <silent> ]c :lnext<CR>
  nmap <silent> [c :lprev<CR>
endtry

