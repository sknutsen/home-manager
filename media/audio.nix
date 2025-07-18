{
  config,
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    spotify
  ];

  services.mpd = {
    enable = true;
  };

  networking.firewall = {
    allowedTCPPorts = [57621];
    allowedUDPPorts = [5353];
  };
}
