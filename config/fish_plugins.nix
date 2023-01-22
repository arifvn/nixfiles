{ pkgs, ... }: [
  {
    name = "z";
    src = pkgs.fetchFromGitHub {
      owner = "jethrokuan";
      repo = "z";
      rev = "85f863f20f24faf675827fb00f3a4e15c7838d76";
      sha256 = "sha256-+FUBM7CodtZrYKqU542fQD+ZDGrd2438trKM0tIESs0=";
    };
  }
  {
    name = "fish-git-abbr";
    src = pkgs.fetchFromGitHub {
      owner = "lewisacidic";
      repo = "fish-git-abbr";
      rev = "abe95203b7fcb1eaa685bd5b75796b52bb7be884";
      sha256 = "sha256-UP+bk5luk6bNrMzI4eQkt9TzU8dkjEqGoEnlEh4fEK4=";
    };
  }
  {
    name = "autopair";
    src = pkgs.fetchFromGitHub {
      owner = "jorgebucaran";
      repo = "autopair.fish";
      rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
      sha256 = "sha256-qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
    };
  }
  {
    name = "puffer-fish";
    src = pkgs.fetchFromGitHub {
      owner = "nickeb96";
      repo = "puffer-fish";
      rev = "fd0a9c95da59512beffddb3df95e64221f894631";
      sha256 = "sha256-aij48yQHeAKCoAD43rGhqW8X/qmEGGkg8B4jSeqjVU0=";
    };
  }
  {
    name = "sponge";
    src = pkgs.fetchFromGitHub {
      owner = "meaningful-ooo";
      repo = "sponge";
      rev = "384299545104d5256648cee9d8b117aaa9a6d7be";
      sha256 = "sha256-MdcZUDRtNJdiyo2l9o5ma7nAX84xEJbGFhAVhK+Zm1w=";
    };
  }
  {
    name = "fish-colored-man";
    src = pkgs.fetchFromGitHub {
      owner = "decors";
      repo = "fish-colored-man";
      rev = "1ad8fff696d48c8bf173aa98f9dff39d7916de0e";
      sha256 = "sha256-uoZ4eSFbZlsRfISIkJQp24qPUNqxeD0JbRb/gVdRYlA=";
    };
  }
  {
    name = "nix-env";
    src = pkgs.fetchFromGitHub {
      owner = "lilyball";
      repo = "nix-env.fish";
      rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
      sha256 = "069ybzdj29s320wzdyxqjhmpm9ir5815yx6n522adav0z2nz8vs4";
    };
  }
]
