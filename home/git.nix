{config, ...}: let
  inherit (config.home.user-info) email username;
in {
  programs.git = {
    enable = true;
    userEmail = email;
    userName = username;
    delta.enable = true;
    delta.options = {
      decorations = {
        commit-decoration-style = "bold blue box ul";
        file-decoration-style = "none";
        file-style = "bold yellow ul";
      };
      features = "decorations";
      line-numbers = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      pull.ff = "only";
      diff.tool = "vimdiff";
      difftool.prompt = false;
      merge.tool = "vimdiff";
      github.user = username;
    };
    ignores = [
      ".node_modules"
      "*.com"
      "*.class"
      "*.dll"
      "*.exe"
      "*.o"
      "*.so"
      "*.pyc"
      "*.pyo"

      # Packages
      "*.7z"
      "*.dmg"
      "*.gz"
      "*.iso"
      "*.jar"
      "*.rar"
      "*.tar"
      "*.zip"
      "*.msi"

      # Logs and databases
      "*.log"
      "*.sql"
      "*.sqlite"

      # OS generated files
      ".DS_Store"
      ".DS_Store?"
      "._*"
      ".Spotlight-V100"
      ".Trashes"
      "ehthumbs.db"
      "Thumbs.db"
      "desktop.ini"

      # Temporary files
      "*.bak"
      "*.swp"
      "*.swo"
      "*~"
      "*#"

      # IDE files
      ".vscode"
      ".idea"
      ".iml"
    ];
  };
}
