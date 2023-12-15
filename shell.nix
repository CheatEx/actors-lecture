# Usage:
# $ python -m pip install git+https://gitlab.com/da_doomer/markdown-slides.git
# $ python -m mdslides slides.md
{ nixpkgs ? import <nixpkgs> {} }:

with nixpkgs;

# let
#   mdslides = import ./markdown-slides.nix {};
# in

mkShell {
  buildInputs = 
    [ elixir_1_13 ] ++ 
    [ glibcLocales libnotify inotify-tools ] ++
    [ python3 python3Packages.setuptools python3Packages.venvShellHook ];
  venvDir = ".python-venv";
}
