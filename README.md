# Kara
A KDE Plasma Applet for use as a desktop/workspace pager. This project is an evolution of GINTI and Desktop Indicator, and further development will be handled here.
Built with extendability in mind.
Currently difficult to manage anchoring and positioning. Could be eliminated by a common component, but requires a lot of testing.

![Untitled](https://github.com/user-attachments/assets/ce3a92b6-ceb7-4858-a26a-78acbc139b57)

# Contributing
## Ideas and nitpicks
All ideas and nitpicks are welcome! This project is actively looking for ideas.

## New highlight style
Look at the .qml files inside ```contents/ui/highlights/```.

It should be self explanatory, the ```op``` property is manipulated inside the component by a loader to give different styles of highlighting.

To test it, add the path to ```contents/ui/Common/HighlightLoader.qml``` file(should also be self-explanatory).

## New Indicator style
These are stored inside ```contents/ui/representations/```. To test yours, add the path to the switch statement inside ```contents/ui/main.qml```.

- Positions are now handled by a gridlayout and thus making future development simple.
- Each representation will be placed inside a parent rectangle. To update the gridlayout of the dimensions of the representation, call updateGeometry(w,h) from within each representation.
- Get to work making your representations, and open a pull request. Make sure to beautify it.

!!If your representation is really close another one, see if it would make more sense to first add a configuration option for it.

## Adding new config options
These will only be added after careful consideration and should not directly be added by the contributor.
If you are opening a pull request for a new indicator or highlight style, hard-code the values temporarily.

# Installation

## Nix package

For those using NixOS or the Nix package manager, you can install the widget using one of these methods:

- NixOS

```nix
environment.systemPackages = with pkgs; [ kara ];
```

- [home-manager](https://github.com/nix-community/home-manager)

```nix
home.packages = with pkgs; [ kara ];
```

- [plasma-manager](https://github.com/nix-community/plasma-manager): If the widget is added to a panel or to the desktop, it will be installed automatically.
- Other distros using nix package manager:

```
# without flakes:
nix-env -iA nixpkgs.kara

# with flakes:
nix profile install nixpkgs#kara
```

## Manual installation

cd into the cloned directory and run ```sh install.sh```.
Or install from the ```Get new widget functionality``` in KDE Plasma.
