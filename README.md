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

### Build dependencies

#### <u>Archlinux</u>
```
sudo pacman -S base-devel cmake extra-cmake-modules qt6-base qt6-declarative kwin \
  libplasma plasma-activities plasma-workspace --noconfirm
```

### <u>openSUSE Tumbleweed</u>
```
sudo zypper in -y cmake gcc-c++ cmake extra-cmake-modules qt6-base-devel qt6-declarative-devel \
  kf6-ki18n-devel kf6-kservice-devel kf6-kwindowsystem-devel libplasma6-devel \
  plasma6-activities-devel kwin6-devel wayland-devel libepoxy-devel \
  libdrm-devel plasma6-workspace-devel kf6-kitemmodels-devel
```

### <u>Fedora</u>
```
sudo dnf install -y cmake extra-cmake-modules g++ qt6-qtbase-devel qt6-qtdeclarative-devel \
  kf6-ki18n-devel kf6-kservice-devel kf6-kwindowsystem-devel libplasma-devel \
  plasma-activities-devel kwin-devel wayland-devel libepoxy-devel \
  libdrm-devel plasma-workspace-devel kf6-kitemmodels-devel
```

### <u>Solus</u>
```
sudo eopkg it -c system.devel && sudo eopkg it kf6-kirigami-devel qt6-qtbase-devel qt6-qtdeclarative-devel \
  kf6-ki18n-devel kf6-kservice-devel kf6-kwindowsystem-devel libplasma-devel \
  plasma-activities-devel kwin-devel wayland-devel libepoxy-devel \
  libdrm-devel plasma-workspace-devel kf6-kitemmodels-devel
```

### <u>Debian14 (forky)</u>
```
sudo apt-get -y install cmake build-essential \
  qt6-declarative-dev extra-cmake-modules \
  qt6-base-dev libkf6i18n-dev libkf6service-dev \
  libkf6windowsystem-dev plasma-workspace-dev libplasmaactivities-dev \
  kwin-dev pkg-config libdrm-dev
```

### <u>KDE Neon (user)</u>
```
sudo apt-get -y install cmake build-essential \
  qt6-declarative-dev extra-cmake-modules \
  qt6-base-dev libkf6i18n-dev libkf6service-dev \
  libkf6windowsystem-dev plasma-workspace-dev libkf6activities-dev \
  kwin-dev pkg-config libdrm-dev gettext
```

> [!NOTE]
> Running either the `dev.sh` or `install.sh` installs for the current user (no system-wide files) typically this is inside $HOME/.local/share/plasma/plasmoids

Clone the repository and choose one of the following scripts:

- **Development**: To test the applet without restarting your desktop, run:
  ```bash
  ./dev.sh
  ```
  This will build, install locally, and open the applet in `plasmoidviewer`.

- **Installation**: To install and apply changes to your live Plasma session, run:
  ```bash
  ./install.sh
  ```
  This will build, install locally, and restart `plasmashell`.

> [!WARNING]
> Due to the move to a c++ plugin environment which requires compilation, this KDE Plasma applet can no longer be installed directly from the KDE store.
