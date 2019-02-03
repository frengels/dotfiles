call plug#begin()
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'

Plug 'mattn/calendar-vim'
Plug 'vimwiki/vimwiki'
call plug#end()

let mapleader=" "

imap fd <Esc>

let g:vimwiki_list = [
			\{'path': '~/Documents/wiki/personal.wiki'}
  \]

au BufRead,BufNewFile *.wiki set filetype=vimwiki
:autocmd FileType vimwiki map d :VimwikiMakeDiaryNot
