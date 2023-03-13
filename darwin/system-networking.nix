{
  networking.dns = [
    # use Cloudflare dns
    # https://developers.cloudflare.com/1.1.1.1/setup/macos/
    "1.1.1.1"
    "1.0.0.1"
    "2606:4700:4700::1111"
    "2606:4700:4700::1001"
  ];
}
