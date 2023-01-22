{ ... }: {
  e = "nvim";
  b = "bat";
  clone = "ghq get";
  du = "dust";
  l = "clear";
  pt = "pkill tmux";
  ef = "exec fish";
  t = "tree";
  to = "touch";

  tm = "tmux";
  tml = "tmux ls";
  tma = "tmux attach";

  mv = "mv -v";
  cp = "cp -vr";
  rm = "rm -vr";
  md = "mkdir -vp";

  gito =
    "git remote -v | awk 'NR==1 { print $2 }' | xargs -ro $BROWSER > /dev/null 2>&1 &";

  # exa
  lst =
    "exa --long --tree --group-directories-first --no-permissions --no-user --no-time --no-filesize";
  lstt =
    "exa --long --tree --group-directories-first --no-permissions --no-user --no-time --no-filesize --level=2";
  lsttt =
    "exa --long --tree --group-directories-first --no-permissions --no-user --no-time --no-filesize --level=3";
  lsd = "exa --long --icons --all --only-dirs";
  lsg = "exa --icons --grid --all --group-directories-first";

  # zip
  mtar = "tar -cvf"; # mtar <archive_compress>
  utar = "tar -xvf"; # utar <archive_decompress> <file_list>
  zip = "zip -r"; # zip <archive_compress> <file_list>
  uz = "unzip"; # uz <archive_decompress> -d <dir>
}
