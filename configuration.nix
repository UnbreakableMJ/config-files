# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

security.doas.enable = true;
security.sudo.enable = true;
security.doas.extraRules = [{
  users = ["mohamedhammad"];
  # Optional, retains environment variables while running commands 
  # e.g. retains your NIX_PATH when applying your config
  keepEnv = true; 
  persist = true;  # Optional, don't ask for the password for some time, after a successfully authentication
}];

  networking.hostName = "nixos"; # Define your hostname.
#  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.userControlled.enable = true;
  users.extraUsers.mohamedhammad.extraGroups = [ "wheel" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Bahrain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Exclude specific apps from GNOME
  #
  environment.gnome.excludePackages = with pkgs; [
    #gnome-tour
    #gnome-connections
    epiphany # web browser
    geary # email reader. Up to 24.05. Starting from 24.11 the package name is just geary.
    #evince # document viewer
  ];

  # Configure keymap in X11
  services.xserver = {
    #layout = "us";
    xkb.layout = "us";
    #xkbVariant = "";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
   # services.xserver.libinput.enable = true;
   services.libinput.enable = true;

  # enable Ozone Wayland support in Chromium and Electron based applications:
  # https://wiki.nixos.org/wiki/Wayland#Electron_and_Chromium
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

# Start Flatpak service
   services.flatpak.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mohamedhammad = {
    isNormalUser = true;
    description = "Mohamed Hammad";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #   thunderbird
       gnome-extension-manager
       gnome-browser-connector
       wpa_supplicant
       wpa_supplicant_gui
       flatpak
    #   emacs
       emacs-gtk
       mg
       hw-probe
       i3
       bitwarden-cli
       bitwarden-desktop
       p7zip
       i7z
       wezterm
       ripgrep
       lapce
       barrier
       tealdeer
       aria2
       uget
       nerdfonts
       terminus_font
       terminus_font_ttf
       nushell
       starship
       libreoffice-fresh
    #   vim
       neovim
       neovim-gtk
       vimacs
       qalculate-gtk
       alacritty
       gedit
       yt-dlp
       distrobox
       boxbuddy
       doas
    #   doas-sudo-shim
       uutils-coreutils
    #   uutils-coreutils-noprefix
       bat
       bottom
       fd
       eza
       macchina
       dust
       broot
       zoxide
       difftastic
       procs
       ouch
       sd
       sad
       rqbit
       htop
    #   htop-vim
       rustup
       google-chrome
       vscode
       vscodium
       ptyxis
       onedriver
       onlyoffice-bin
       corefonts
       superfile
       warp-terminal
       tutanota-desktop
       betterbird
       opera
       ventoy-full
       termius
       appimage-run
       dconf-editor
       mc
       screen
       ion
       nerdfonts
       fira-code-nerdfont
       jetbrains-mono
       noto-fonts-color-emoji
       gotop
       amp
       jdk
       curlFull
       zed-editor
       btop
       moar
       os-prober
    ];
  };

  # Enable automatic login for the user.
  # services.xserver.displayManager.autoLogin.enable = false;
  # services.xserver.displayManager.autoLogin.user = "mohamedhammad";
  services.displayManager.autoLogin.enable = false;
  services.displayManager.autoLogin.user = "mohamedhammad";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  #systemd.services."getty@tty1".enable = false;
  #systemd.services."autovt@tty1".enable = false;

  # Install firefox.
  programs.firefox.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    pkgs.google-chrome
    pkgs.gnome-extension-manager
    pkgs.gnome-browser-connector
    pkgs.gnomeExtensions.forge
    pkgs.gnomeExtensions.caffeine
    pkgs.gnomeExtensions.just-perfection
    pkgs.gnomeExtensions.switcher
    pkgs.gnomeExtensions.window-gestures
    pkgs.gnomeExtensions.wayland-or-x11
    pkgs.gnomeExtensions.toggler
    pkgs.gnomeExtensions.vim-alt-tab
    pkgs.gnomeExtensions.onedrive
    pkgs.gnomeExtensions.multicore-system-monitor
    pkgs.gnomeExtensions.yakuake
    pkgs.gnomeExtensions.open-bar
    pkgs.gnomeExtensions.tweaks-in-system-menu
    pkgs.gnomeExtensions.launcher
    pkgs.gnomeExtensions.window-title-is-back
    pkgs.mc
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  pkgs.vim
    pkgs.wget
    pkgs.neovim
    pkgs.neovim-gtk
    pkgs.mg
    pkgs.emacs-gtk
    pkgs.vimacs
    pkgs.doas
  #  pkgs.doas-sudo-shim
    pkgs.uutils-coreutils
  #  pkgs.uutils-coreutils-noprefix
    pkgs.bat
    pkgs.bottom
    pkgs.fd
    pkgs.eza
    pkgs.macchina
    pkgs.dust
    pkgs.broot
    pkgs.zoxide
    pkgs.difftastic
    pkgs.procs
    pkgs.ouch
    pkgs.sd
    pkgs.sad
    pkgs.htop
  #  pkgs.htop-vim
    pkgs.rustup
    pkgs.corefonts
    pkgs.superfile
    pkgs.mc
    pkgs.screen
    pkgs.ion
    pkgs.starship
    pkgs.nushell
    pkgs.nerdfonts
    pkgs.fira-code-nerdfont
    pkgs.jetbrains-mono
    pkgs.noto-fonts-color-emoji
    pkgs.gotop
    pkgs.amp
    pkgs.curlFull
    pkgs.jdk
    pkgs.btop
    pkgs.moar
    pkgs.os-prober
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

# Start my emacs in the background as daemon
  services.emacs = {
    enable = true;
    package = pkgs.emacs-gtk; # replace with emacs-gtk, or a version provided by the community overlay if desired.
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

nix.settings.system-features = [
  "gccarch-sandybridge" 
];

nixpkgs.hostPlatform = { 
  cpu = "sandybridge"; # Or your desired architecture
  system = "x86_64-linux"; 
};

# Enable auto update of system (auto rebuild)
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

#qt = {
#  enable = true;
#  platformTheme = "gnome";
#  style.name = "adwaita-dark";
#};

# Register AppImage files as a binary type to binfmt_misc
# https://nixos.wiki/wiki/Appimage
boot.binfmt.registrations.appimage = {
  wrapInterpreterInShell = false;
  interpreter = "${pkgs.appimage-run}/bin/appimage-run";
  recognitionType = "magic";
  offset = 0;
  mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
  magicOrExtension = ''\x7fELF....AI\x02'';
};

#home.file."${config.xdg.configHome}" = {
#  source = ./dotfiles;
#  recursive = true;
#};

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
