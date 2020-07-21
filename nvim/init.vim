set encoding=utf-8

" enable 24 bit color support if supported
if (has("termguicolors"))
    if (!(has("nvim")))
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    set termguicolors
endif

set termguicolors

" General Mappings {{{

    " set a map leader for more key combos
    let mapleader = ','

    " Testing
    map <silent> <C-h> :call functions#WinMove('h')<cr>
    map <silent> <C-j> :call functions#WinMove('j')<cr>
    map <silent> <C-k> :call functions#WinMove('k')<cr>
    map <silent> <C-l> :call functions#WinMove('l')<cr>

    " Open tagbar
    nmap <leader>t :call functions#TagbarToggleFocus()<CR>

    " edit nvim config
    map <leader>ev :e! ~/.config/nvim/init.vim<cr>

    " CtrlP for Tags
    nmap <leader>p :CtrlPTag<CR>

    " toggle between C++ header and source
    nmap <leader>a :A<CR>

    " resize windows evenly
    nmap <leader>= :wincmd =<CR>

    " clear highlighted search
    noremap <space> :set hlsearch! hlsearch?<cr>

    " toggle display of SpecialKeys
    nmap <leader>l :set list!<cr>

    " scroll viewport faster
    nnoremap <C-e> 3<C-e>
    nnoremap <C-y> 3<C-y>

    nnoremap <F5> :GundoToggle<CR>

    if executable('ag')
      let g:ackprg = 'ag --vimgrep'
    endif

" }}}

" ensure vim-plug is installed and then load

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-surround'
Plug 'flrnd/candid.vim'
Plug 'dracula/vim',{'as':'dracula'}
Plug 'sjl/badwolf',{'as':'badwolf'}
Plug 'https://github.com/sjl/gundo.vim.git'
Plug 'https://github.com/mileszs/ack.vim.git'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/a.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'xavierd/clang_complete'
Plug 'npacker/vim-css3complete'
Plug 'ap/vim-css-color'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'

    " NERDTree {{{
        Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
        "let NERDTreeDirArrowExpandable = "\u00a0" " make arrows invisible
        "let NERDTreeDirArrowCollapsible = "\u00a0" " make arrows invisible
        "let NERDTreeNodeDelimiter = "\u263a" " smiley face

        augroup nerdtree
            autocmd!
            autocmd FileType nerdtree setlocal nolist " turn off whitespace characters
            autocmd FileType nerdtree setlocal nocursorline " turn off line highlighting for performance
        augroup END

        " Toggle NERDTree
        function! ToggleNerdTree()
            if @% != "" && @% !~ "Startify" && (!exists("g:NERDTree") || (g:NERDTree.ExistsForTab() && !g:NERDTree.IsOpen()))
                :NERDTreeFind
            else
                :NERDTreeToggle
            endif
        endfunction
        " toggle nerd tree
        nmap <silent> <leader>k :call ToggleNerdTree()<cr>
        " find the current file in nerdtree without needing to reload the drawer
        nmap <silent> <leader>y :NERDTreeFind<cr>

        let NERDTreeShowHidden=1
        let NERDTreeDirArrowExpandable = '▷'
        let NERDTreeDirArrowCollapsible = '▼'
    " }}}

call plug#end()

" Color scheme stuff
colorscheme dracula


" Tabs and formatting
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set number

" Nice to have
set showcmd
set cursorline
filetype indent on
set so=7
set wildmenu
set shell=$SHELL
set showmatch
syntax on

" Searching
set ignorecase
set smartcase
set showmatch
set incsearch
set hlsearch

" Indenting
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=syntax

" Tentative
set listchars=eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
let g:clang_library_path='/usr/lib/llvm-8/lib'
"hi clear cursorline

" autocommands

autocmd VimResized * wincmd =

" Abbreviations
abbr funciton function
abbr teh the
abbr tempalte template
abbr fitler filter
abbr cosnt const
abbr attribtue attribute
abbr attribuet attribute


" autocomplete qol 

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
