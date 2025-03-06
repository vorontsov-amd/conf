{ config, pkgs, ... }:

rec {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "amadey";
  home.homeDirectory = "/home/amadey";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    git
    cmake
    clang

    any-nix-shell

    cascadia-code
    eza

    quartus-prime-lite
  ];

  services.picom = {
    enable = true;
    backend = "glx";

    settings = {
      corner-radius = 5;

      blur = true;
      blur-method = "dual_kawase";
      blur-strength = "10";

      blur-background-exclude = [
        "!(class_g ~= '^Alacritty$')"
      ];
    };

    vSync = true;
  };

  programs.alacritty = {
    enable = true;

    settings = {
      font = {
        normal = {
          family = "Cascadia Code";
        };
      };

      window.padding = { x = 4; y = 4; };
      window.opacity = 0.9;

      keyboard.bindings = [{
        key = "Return";
        mods = "Control|Shift";
        action = "SpawnNewInstance";
      }];

      colors = {
        primary = {
            background = "0x1c1d20";
            foreground = "0xfff1f3";
        };

        normal = {
            black      = "0x2c2525";
            red        = "0xfd6883";
            green      = "0xadda78";
            yellow     = "0xf9cc6c";
            blue       = "0xf38d70";
            magenta    = "0xa8a9eb";
            cyan       = "0x85dacc";
            white      = "0xfff1f3";
        };

        bright = {
            black      = "0x72696a";
            red        = "0xfd6883";
            green      = "0xadda78";
            yellow     = "0xf9cc6c";
            blue       = "0xf38d70";
            magenta    = "0xa8a9eb";
            cyan       = "0x85dacc";
            white      = "0xfff1f3";
        };
      };
    };
  };


  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;

    enableCompletion = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      bindkey '^H' backward-kill-word
      bindkey '5~' kill-word

      any-nix-shell zsh --info-right | source /dev/stdin

      export DISABLE_MAGIC_FUNCTIONS=true
      export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
    '';

    shellAliases = {
      ls = "${pkgs.eza}/bin/eza";
    };

    history.size = 1000000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };


  programs.home-manager.enable = true;
}
