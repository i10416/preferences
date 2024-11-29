{ ... }:
{
  networking = {
    dns = [
      "8.8.8.8"
      "127.0.0.1"
    ];
    search = [ "local" ];
    knownNetworkServices = [
      "Ethernet"
      "Wi-Fi"
    ];
  };
}
