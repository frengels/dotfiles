{ config, lib, pkgs, ... }:
{
  programs.neovim = {
    enable = true;

    extraConfig = ''
      let mapleader=" "

      imap fd <Esc>

      au BufRead,BufNewFile *.wiki set filetype=vimwiki
      :autocmd FileType vimwiki map d :VimwikiMakeDiaryNot

      set clipboard+=unnamedplus

      set matchpairs+=<:>
    '';

    plugins = with pkgs.vimPlugins; [
      ultisnips
      vim-snippets
      fzf-vim
      lightline-vim
      vim-multiple-cursors
      vim-eunuch
      vim-surround
      vim-fugitive
      nerdtree
      editorconfig-vim
      vim-gitgutter

      calendar-vim
      vimwiki
      neoformat
    ];
  };
}
