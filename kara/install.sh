rm -rf ~/.local/share/plasma/plasmoids/org.dhruv8sh.kara
cp -r ../kara ~/.local/share/plasma/plasmoids/org.dhruv8sh.kara
systemctl --user restart plasma-plasmashell
