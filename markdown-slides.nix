{nixpkgs ? import <nixpkgs> {}}:
with nixpkgs;

python3Packages.buildPythonPackage rec {
  name = "markdown-slides";
  version = "0.0";

  src = fetchFromGitLab {
    owner = "da_doomer";
    repo = "${name}";
    rev = "90b0f29f92971aca3593c9a3ae71ebac2f4468d8";
    sha256 = "1vgiv1sq98h88g3i90v2nhikpi8idb7bf9kj6kpqyd8sd61cs66z";
    fetchSubmodules = true;
    # deepClone = true;
    # leaveDotGit = true;
  };

  propagatedBuildInputs = [  ];
}
