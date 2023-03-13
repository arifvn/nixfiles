{lib, ...}: let
  inherit (lib) mkDefault;
in {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      command_timeout = 1000;
      cmd_duration = {
        format = " [$duration]($style) ";
        style = "bold #EC7279";
        show_notifications = true;
      };
      nix_shell = {
        format = " [$symbol$state]($style) ";
        symbol = mkDefault " ";
      };
      battery = {
        full_symbol = "🔋 ";
        charging_symbol = "⚡️ ";
        discharging_symbol = "💀 ";
      };
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
        vicmd_symbol = "[V](bold green)";
      };
      git_branch = {
        format = "[$symbol$branch]($style) ";
        symbol = mkDefault " ";
      };
      gcloud = {
        format = "[$symbol$active]($style) ";
        symbol = mkDefault " ";
      };

      aws.symbol = mkDefault " ";
      cmake.symbol = mkDefault "△ ";
      conda.symbol = mkDefault " ";
      crystal.symbol = mkDefault " ";
      dart.symbol = mkDefault " ";
      directory.read_only = mkDefault " ";
      docker_context.symbol = mkDefault " ";
      dotnet.symbol = mkDefault " ";
      elixir.symbol = mkDefault " ";
      elm.symbol = mkDefault " ";
      erlang.symbol = mkDefault " ";
      git_commit.tag_symbol = mkDefault " ";
      golang.symbol = mkDefault " ";
      helm.symbol = mkDefault "⎈ ";
      hg_branch.symbol = mkDefault " ";
      java.symbol = mkDefault " ";
      julia.symbol = mkDefault " ";
      kotlin.symbol = mkDefault " ";
      kubernetes.symbol = mkDefault "☸ ";
      lua.symbol = mkDefault " ";
      memory_usage.symbol = mkDefault " ";
      nim.symbol = mkDefault " ";
      nodejs.symbol = mkDefault " ";
      openstack.symbol = mkDefault " ";
      package.symbol = mkDefault " ";
      perl.symbol = mkDefault " ";
      php.symbol = mkDefault " ";
      purescript.symbol = mkDefault "<≡> ";
      python.symbol = mkDefault " ";
      ruby.symbol = mkDefault " ";
      rust.symbol = mkDefault " ";
      shlvl.symbol = mkDefault " ";
      status.symbol = mkDefault " ";
      status.not_executable_symbol = mkDefault " ";
      status.not_found_symbol = mkDefault " ";
      status.sigint_symbol = mkDefault " ";
      status.signal_symbol = mkDefault " ";
      swift.symbol = mkDefault " ";
      terraform.symbol = mkDefault "𝗧 ";
      vagrant.symbol = mkDefault "𝗩 ";
      zig.symbol = mkDefault " ";
    };
  };
}
