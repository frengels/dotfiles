function! Build_YCM(info)
    " info is a dictionary with 3 fields
    " - name: name of the plugin
    " - status: 'installed', 'updated', or 'unchanged'
    " - force: set on PlugInstall! or PlugUpdate!
    if a:info.status == 'installed' || a:info.force
        !./install.py --all --system-libclang --system-boost
    endif
endfunction


call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'Valloric/YouCompleteMe', { 'do': function('Build_YCM') }
"Plug 'rdnetto/YCM-Generator', { 'branch': 'develop'} " not working currently
Plug 'vim-airline/vim-airline'
Plug 'tomasiser/vim-code-dark'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'jlanzarotta/bufexplorer'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'rhysd/vim-clang-format'
Plug 'flazz/vim-colorschemes'
call plug#end()

let mapleader=";"

set number
colorscheme wombat256mod

let g:airline_powerline_fonts = 1

" keybinds for buffer navigation

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>

" YCM config
" uses compilation database it can find, sucks on header only libraries
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/.ycm_extra_conf.py'

nnoremap <Leader>yi :YcmCompleter GoToInclude<CR>
nnoremap <Leader>yd :YcmCompleter GoToDeclaration<CR>
nnoremap <Leader>ye :YcmCompleter GoToDefinition<CR>
nnoremap <Leader>yc :YcmCompleter GoToImprecise<CR>
nnoremap <Leader>yt :YcmCompleter GetType<CR>
nnoremap <Leader>yo :YcmCompleter GetDoc<CR>
nnoremap <Leader>yp :YcmCompleter GetDocImprecise<CR>

" NERDTree config
nnoremap <Leader>t :NERDTree<CR>
let NERDTreeShowHidden=1

" CtrlP
nnoremap <leader>o :CtrlP<CR>
nnoremap <leader>i :CtrlPBuffer<CR>

" clang-format
nnoremap <Leader>cf :ClangFormat<CR>
vnoremap <Leader>cf :ClangFormat<CR>

" snippets
let g:UltiSnipsExpandTrigger="<tab>"

" ignored files
set wildignore+=*.o,*.so,*.swap,*.zip

" basic settings
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set clipboard+=unnamedplus


set foldmethod=indent
set foldnestmax=3
set nofoldenable
