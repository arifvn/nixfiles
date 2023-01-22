{ ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set number
      set winbar=%f
      set clipboard+=unnamedplus

      :lua vim.o.ls = 0

      nmap <C-z> :suspend<CR>
    '';
  };
}
