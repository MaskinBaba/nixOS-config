{ lib, ... }:
{
  hardware.raspberry-pi.config = {
    all = {
      # [all] conditional filter, https://www.raspberrypi.com/documentation/computers/config_txt.html#conditional-filters
      options.enable_uart = {
          enable = true;
          value = true;
      };
     # https://www.raspberrypi.com/documentation/computers/config_txt.html#uart_2ndstage
     # enable debug logging to the UART, also automatically enables 
     # UART logging in `start.elf`
     options.uart_2ndstage = {
       enable = true;
       value = true;
     };

      # Base DTB parameters
      # https://github.com/raspberrypi/linux/blob/a1d3defcca200077e1e382fe049ca613d16efd2b/arch/arm/boot/dts/overlays/README#L132
      base-dt-params = {
        # https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#enable-pcie
        pciex1 = {
          enable = true;
          value = "on";
        };
        # PCIe Gen 3.0
        # https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#pcie-gen-3-0
        pciex1_gen = {
          enable = true;
          value = "3";
        };

        # Disable default audio driver
        # https://www.hifiberry.com/docs/software/configuring-linux-3-18-x/
        # audio.enable = lib.mkForce false;

        # Disable LEDs
        # https://dky.io/posts/how-to-disable-the-status-leds-on-a-raspberry-pi-5/
        # pwr_led_trigger = {
        #   enable = true;
        #   value = "default-on";
        # };
        # pwr_led_activelow = {
        #   enable = true;
        #   value = "off";
        # };
        # act_led_trigger = {
        #   enable = true;
        #   value = "none";
        # };
        # act_led_activelow = {
        #   enable = true;
        #   value = "off";
        # };
        # eth_led0 = {
        #   enable = true;
        #   value = 4;
        # };
        # eth_led1 = {
        #   enable = true;
        #   value = 4;
        # };
      };

      # dt-overlays = {
      #   # Enable DRM VC4 V3D driver without audio
      #   # https://www.hifiberry.com/docs/software/configuring-linux-3-18-x/
      #   vc4-kms-v3d.enable = lib.mkForce false;
      #   "vc4-kms-v3d,noaudio" = {
      #     enable = true;
      #     params = { };
      #   };
      #   # Use HiFiBerry driver
      #   # https://www.hifiberry.com/docs/software/configuring-linux-3-18-x/
      #   "hifiberry-dacplus-std,leds_off" = {
      #     enable = true;
      #     params = { };
      #   };
      # };
    };
  };
}
