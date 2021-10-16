# Usage:
# $ python -m pip install git+https://gitlab.com/da_doomer/markdown-slides.git
# $ mdslides
{ nixpkgs ? import <nixpkgs> {} }:

with nixpkgs;

let
  mdslides = import ./markdown-slides.nix {};
in

mkShell {
  buildInputs = 
    [ elixir ] ++ 
    [ glibcLocales libnotify inotify-tools ] ++
    [ python3 python3Packages.setuptools python3Packages.venvShellHook ];
  venvDir = ".python-venv";
}
