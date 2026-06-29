{  lib, config, ...}:
{
  services.homepage-dashboard = {
    enable = true;
    allowedHosts = "localhost:8082,127.0.0.1:8082,home.maskinscache.xyz";
    customCSS = ''
      body, html {
        font-family: SF Pro Display, Helvetica, Arial, sans-serif !important;
      }
      .font-medium {
        font-weight: 700 !important;
      }
      .font-light {
        font-weight: 500 !important;
      }
      .font-thin {
        font-weight: 400 !important;
      }
      #information-widgets {
        padding-left: 1.5rem;
        padding-right: 1.5rem;
      }
      div#footer {
        display: none;
      }
      .services-group.basis-full.flex-1.px-1.-my-1 {
        padding-bottom: 3rem;
      };
    '';
    settings = {
      layout = [
        {
          Glances = {
            header = false;
            style = "row";
            columns = 4;
          };
        }
        {
          Arr = {
            header = true;
            style = "column";
          };
        }
        {
          Downloads = {
            header = true;
            style = "column";
          };
        }
        {
          Media = {
            header = true;
            style = "column";
          };
        }
        {
          Services = {
            header = true;
            style = "column";
          };
        }
      ];
      headerStyle = "clean";
      statusStyle = "dot";
      hideVersion = "true";
    };
    services = [
      {
        "My First Group" = [
          {
            "Network" = {
              description = "Network Stack here";
            };
          }
          {
            "Cloudflare" = {
              description = "Cloudflred here";
              href = "http://localhost/";
            };
          }
          {
            "Speed maybe or whatever" = {
              description = "Homepage is awesome";
              href = "http://localhost/";
            };
          }
        ];
      }
      {
        "" = [
          {
            "My Second Service" = {
              description = "Homepage is the best";
              href = "http://localhost/";
            };
          }
        ];
      }
    ];
    widgets = [
      {
        resources = {
          label = "Info";
          cpu = true;
          memory = true;
          tempmin = 0;
          tempmax = 80;
          cputemp = true;
        };
      }
      {
        resources = {
          label = "Storage";
          disk = [ "/" ];
        };
      }
      {
        cloudflared = {
          accountid = "270167642c16d1070b2e2bf65ae86b13";
          tunnelid = "1cbc7afb-97ee-487a-80c0-1e74f6960f3d"; # found in tunnels dashboard under the tunnel name
          key = config.sops.secrets."server/cf_read_tunnel_key".path; # api token with `Account.Cloudflare Tunnel:Read` https://dash.cloudflare.com/profile/api-tokens
        };
      }
      {
        search = {
          provider = "duckduckgo";
          target = "_blank";
        };
      }
      {
        openweathermap = {
          label = "Nashik";
          latitude = "20.02553782633677";
          longitude = "73.84192514402312";
          units = "metric";
          provider = "openweathermap";
          apikey = "0eef18e6297a8395c2119bc3856527f7";
          cache = 30;
          # format = "_blank";
        };
      }
    ];
  };
}
