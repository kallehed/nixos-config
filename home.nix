
{ config, pkgs, ...}:

{
  home.username = "kalle";
  home.homeDirectory = "/home/kalle";

  home.packages = with pkgs; [
    nnn 
    # could delete
    helvum
    # look at wayland inputs
    wev 
    # necessary for Hyprland config:
    grimblast waybar xfce.ristretto mpv pavucontrol
    fuzzel wl-clipboard libnotify
    brightnessctl google-chrome
    # for screen recording with "record" alias
    slurp wf-recorder ffmpeg 

    #deving
    rust-analyzer rustfmt lldb helix
    # dev things that shouldn't be here actually but IDC
    cargo rustc rustfmt

  ];

  programs.git = {
    enable = true;
    userName = "kallehed";
    userEmail = "kallehed@gmail.com";
  };
  programs.gitui.enable = true;

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 13;
	normal.family = "FiraCode Nerd Font Mono";
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;
    oh-my-zsh.enable = true;
    oh-my-zsh.theme = "intheloop";
    shellAliases = {
      record = "wf-recorder -g \"$(slurp)\" -r 24  -f recording.mp4";
    };
  };

  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;

  home.file.".config/waybar/config".source = ./waybar/config;
  home.file.".config/waybar/style.css".source = ./waybar/style.css;

  home.file.".config/helix/config.toml".source = ./helix/config.toml;

  services.mako = {
    enable = true;
#    backgroundColor = "#e0af68";
#    borderColor = "#cbccd1";
    borderRadius = 5;
    borderSize = 2;
#    textColor = "#7fbbb3";
    layer = "overlay";
  };

  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 55.7;
    longitude = 13.2;
    temperature.night = 1000;
  };

  gtk = {
    enable = true;
    theme.name = "adw-gtk3";
    cursorTheme.name = "Bibata-Modern-Ice";
    iconTheme.name = "GruvboxPlus";
  };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = [ "neovide.desktop" ];
    "application/pdf" = [ "google-chrome.desktop" ];
    "image/*" = [ "org.xfce.ristretto.desktop" ];
    "video/png" = [ "mpv.desktop" ];
    "video/jpg" = [ "mpv.desktop" ];
    "video/*" = [ "mpv.desktop" ];
  };

  qt.enable = true;
  qt.platformTheme = "gtk";
  qt.style.name = "adwaita";
  qt.style.package = pkgs.adwaita-qt;

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}

