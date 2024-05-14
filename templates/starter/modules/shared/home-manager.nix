{ config, pkgs, lib, ... }:

let name = "zaiheshi";
    user = "zaiheshi";
    email = "zaiheshi@gmail.com"; in
{
  # Shared shell configuration
  zsh = {
    enable = true;
    enableCompletion = true;
    # autosuggestions.enable = true;
    # syntaxHighlighting.enable = true;
  };

  git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
	    editor = "vim";
        autocrlf = "input";
      };
      commit.gpgsign = true;
      # pull.rebase = true;
      # rebase.autoStash = true;
    };
  };

  vim = {
    enable = true;
    extraConfig = ''
      let mapleader=" "
      colorscheme desert
      set encoding=utf-8
      set mouse=a

      set nocompatible
      set nobackup
      set noswapfile
      set ignorecase
      set textwidth=80

      filetype plugin on
      syntax on

      " 解决insert模式下面退格键不能用的问题
      set backspace=indent,eol,start

      set nu
      " set relativenumber
      set ts=4
      set shiftwidth=4
      set expandtab

      nnoremap <leader>w :w<CR>
      nnoremap <leader>q :q<CR>
      nnoremap j gj
      '';
     };

  ssh = {
    enable = true;
  };

}
