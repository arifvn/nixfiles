{config, ...}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.home.user-info) nixConfigDirectory;
in {
  programs.neovim.enable = true;
  xdg.configFile."nvim/lua".source = mkOutOfStoreSymlink "${nixConfigDirectory}/config/nvim/lua";
  xdg.configFile."nvim/.stylua.toml".source = mkOutOfStoreSymlink "${nixConfigDirectory}/config/nvim/.stylua.toml";
  xdg.configFile."nvim/init.lua".source = mkOutOfStoreSymlink "${nixConfigDirectory}/config/nvim/init.lua";
  xdg.configFile."nvim/lazy-lock.json".text = ''    {
      "Comment.nvim": { "branch": "master", "commit": "8d3aa5c22c2d45e788c7a5fe13ad77368b783c20" },
      "LuaSnip": { "branch": "master", "commit": "a835e3d680c5940b61780c6af07885db95382478" },
      "SmoothCursor.nvim": { "branch": "main", "commit": "b61173fb107455f18099715b88d86002579f2736" },
      "bufferline.nvim": { "branch": "main", "commit": "b337fd393cef2e3679689d220e2628722c20ddcb" },
      "cmp-buffer": { "branch": "main", "commit": "3022dbc9166796b644a841a02de8dd1cc1d311fa" },
      "cmp-emoji": { "branch": "main", "commit": "19075c36d5820253d32e2478b6aaf3734aeaafa0" },
      "cmp-nvim-lsp": { "branch": "main", "commit": "0e6b2ed705ddcff9738ec4ea838141654f12eeef" },
      "cmp-nvim-lua": { "branch": "main", "commit": "f3491638d123cfd2c8048aefaf66d246ff250ca6" },
      "cmp-path": { "branch": "main", "commit": "91ff86cd9c29299a64f968ebb45846c485725f23" },
      "cmp_luasnip": { "branch": "master", "commit": "18095520391186d634a0045dacaa346291096566" },
      "fidget.nvim": { "branch": "main", "commit": "688b4fec4517650e29c3e63cfbb6e498b3112ba1" },
      "friendly-snippets": { "branch": "main", "commit": "2f5b8a41659a19bd602497a35da8d81f1e88f6d9" },
      "gitsigns.nvim": { "branch": "main", "commit": "b1f9cf7c5c5639c006c937fc1819e09f358210fc" },
      "indent-blankline.nvim": { "branch": "master", "commit": "018bd04d80c9a73d399c1061fa0c3b14a7614399" },
      "lazy.nvim": { "branch": "main", "commit": "8456a867f79e3fb3b5390659c5d11a1e35793372" },
      "leap.nvim": { "branch": "main", "commit": "f74473d23ebf60957e0db3ff8172349a82e5a442" },
      "lsp-colors.nvim": { "branch": "main", "commit": "2bbe7541747fd339bdd8923fc45631a09bb4f1e5" },
      "lspkind.nvim": { "branch": "master", "commit": "c68b3a003483cf382428a43035079f78474cd11e" },
      "lspsaga.nvim": { "branch": "main", "commit": "db6cdf51bf5ae45e4aa65760e597cf0d587c66ee" },
      "lualine.nvim": { "branch": "master", "commit": "e99d733e0213ceb8f548ae6551b04ae32e590c80" },
      "markdown-preview.nvim": { "branch": "master", "commit": "02cc3874738bc0f86e4b91f09b8a0ac88aef8e96" },
      "mason-lspconfig.nvim": { "branch": "main", "commit": "d1a76a59371813d16b5ef0deab209b85db5d19cd" },
      "mason-null-ls.nvim": { "branch": "main", "commit": "4070ec7c543b67df16143ee206e436d24bb9c01b" },
      "mason.nvim": { "branch": "main", "commit": "080cccf82b874df2898f73dcdb09b285a0824334" },
      "noice.nvim": { "branch": "main", "commit": "0c493e5d243c39adf3d6ce7683a16e610cc44e0a" },
      "nui.nvim": { "branch": "main", "commit": "0dc148c6ec06577fcf06cbab3b7dac96d48ba6be" },
      "null-ls.nvim": { "branch": "main", "commit": "456a983ce9843123e51b955f50925077ca7207d5" },
      "nvim-autopairs": { "branch": "master", "commit": "e755f366721bc9e189ddecd39554559045ac0a18" },
      "nvim-cmp": { "branch": "main", "commit": "777450fd0ae289463a14481673e26246b5e38bf2" },
      "nvim-highlight-colors": { "branch": "main", "commit": "ce11467796389a4e5838c22384f94c624121796b" },
      "nvim-lastplace": { "branch": "main", "commit": "65c5d6e2501a3af9c2cd15c6548e67fa035bf640" },
      "nvim-lspconfig": { "branch": "master", "commit": "5a871409199d585b52b69952532e3fb435e64566" },
      "nvim-tree.lua": { "branch": "master", "commit": "1d79a64a88af47ddbb55f4805ab537d11d5b908e" },
      "nvim-treesitter": { "branch": "master", "commit": "dcb9a89ab4f0091bf87aed4e6801423d3667f76a" },
      "nvim-treesitter-textobjects": { "branch": "master", "commit": "5b2bcb9ca8315879181f468b37a897100d631005" },
      "nvim-ts-autotag": { "branch": "main", "commit": "25698e4033cd6cd3745454bfc837dd670eba0480" },
      "nvim-ufo": { "branch": "main", "commit": "9e829d5cfa3de6a2ff561d86399772b0339ae49d" },
      "nvim-web-devicons": { "branch": "master", "commit": "585dbc29315ca60be67d18ae6175771c3fb6791e" },
      "onedark.nvim": { "branch": "master", "commit": "4497678c6b1847b663c4b23000d55f28a2f846ce" },
      "plenary.nvim": { "branch": "master", "commit": "253d34830709d690f013daf2853a9d21ad7accab" },
      "promise-async": { "branch": "main", "commit": "7fa127fa80e7d4d447e0e2c78e99af4355f4247b" },
      "schemastore.nvim": { "branch": "main", "commit": "ac100fa691b10dd990ca0cdc31ebd054a5959b58" },
      "smart-splits.nvim": { "branch": "master", "commit": "52b521618511b3a874255c8a717ace7155fd5f21" },
      "telescope-fzf-native.nvim": { "branch": "main", "commit": "580b6c48651cabb63455e97d7e131ed557b8c7e2" },
      "telescope.nvim": { "branch": "0.1.x", "commit": "766a45a972408f67e793a3b63e3c419ff5458753" },
      "trouble.nvim": { "branch": "main", "commit": "67337644e38144b444d026b0df2dc5fa0038930f" },
      "typescript.nvim": { "branch": "main", "commit": "f66d4472606cb24615dfb7dbc6557e779d177624" },
      "vim-bbye": { "branch": "master", "commit": "25ef93ac5a87526111f43e5110675032dbcacf56" },
      "vim-noh": { "branch": "master", "commit": "b8d35a2eeb7e42d2cc1bb62389ca0d643d8c378c" },
      "vim-repeat": { "branch": "master", "commit": "24afe922e6a05891756ecf331f39a1f6743d3d5a" },
      "vim-search-pulse": { "branch": "master", "commit": "3ae2681332c52ed54c443e09d2ef09ae05eaa445" },
      "vim-surround": { "branch": "master", "commit": "3d188ed2113431cf8dac77be61b842acb64433d9" },
      "vim-tmux-navigator": { "branch": "master", "commit": "cdd66d6a37d991bba7997d593586fc51a5b37aa8" },
      "vim-tpipeline": { "branch": "master", "commit": "bde36fce7165f6b414afab6a0723133730f0f27d" },
      "vim-visual-multi": { "branch": "master", "commit": "724bd53adfbaf32e129b001658b45d4c5c29ca1a" }
    }'';
}
