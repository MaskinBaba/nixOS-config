{
  services.home-assistant = {
    enable = true;
    # Pass the path to the directory where your configuration.yaml
    # resides, /var/lib/hass might be a good location.
    config = null;
    lovelaceConfig = null;
    # configure the path to your config directory
    configDir = "/etc/home-assistant";
    # Override the package to handle dependency management manually
    extraComponents = [
      # Components required to complete the onboarding
      "esphome"
      "met"
      "radio_browser"
    ];
  };
}
