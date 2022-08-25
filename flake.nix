{
  description = "A flake defining gotestfmt build-from-source";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.05;
    gotestfmt-src = {
      url = "github:haveyoudebuggedit/gotestfmt/v2.3.2";
      flake = false;
    };
  };

  outputs =
    { self,
      nixpkgs,
      gotestfmt-src,
    }:

    let
      ver = "2.3.2";

      package = { system }:
        let
          pkgs = import nixpkgs { system = system; };
        in pkgs.buildGoModule rec {
          name = "gotestfmt-${ver}";
          version = "${ver}";
          src = gotestfmt-src;
          vendorSha256 = "pQpattmS9VmO3ZIQUFn66az8GSmB4IvYhTTCFn6SUmo=";
        };
    in {
      packages.x86_64-linux.default = package {
        system = "x86_64-linux";
      };
      packages.x86_64-darwin.default = package {
        system = "x86_64-darwin";
      };
    };
}
