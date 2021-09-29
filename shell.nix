{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  mdslides = import ./markdown-slides.nix {};
in

# mkShell {
#   buildInputs = 
#     [ elixir ] ++ 
#     [ glibcLocales libnotify inotify-tools ] ++
#     [ python3 mdslides ];
# }

mkShell {
  buildInputs = 
    [ elixir ] ++ 
    [ glibcLocales libnotify inotify-tools ] ++
    [ python3 python3Packages.setuptools python3Packages.venvShellHook ];
  venvDir = ".python-venv";
  # python -m pip install git+https://gitlab.com/da_doomer/markdown-slides.git
}
