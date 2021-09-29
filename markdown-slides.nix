let
  pkgs = import <nixpkgs> {};
in
  {}: pkgs.python3Packages.buildPythonPackage rec {
    name = "markdown-slides";
    version = "0.0";

    src = pkgs.fetchFromGitLab {
      owner = "da_doomer";
	    repo = "${name}";
	    rev = "90b0f29f92971aca3593c9a3ae71ebac2f4468d8";
	    sha256 = "0141ali4j0cyqwzrqbgzbp83x8xjjln402243ml1gy26ymdfdpad";
      fetchSubmodules = true;
      deepClone = true;
      leaveDotGit = true;
    };

    propagatedBuildInputs = [  ];
  }
