{
  description = ''Raw system calls for Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."syscall-master".dir   = "master";
  inputs."syscall-master".owner = "nim-nix-pkgs";
  inputs."syscall-master".ref   = "master";
  inputs."syscall-master".repo  = "syscall";
  inputs."syscall-master".type  = "github";
  inputs."syscall-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."syscall-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}