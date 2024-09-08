## WIP - Ready for daily use
## Currently half-broken for vertical panels

# Kara
A KDE Plasma Applet for use as a desktop/workspace pager. This project is an evolution of GINTI and Desktop Indicator, and further development will be handled here.
Built with extendability in mind.
Currently difficult to manage anchoring and positioning. Could be eliminated by a common component, but requires a lot of testing.

![Untitled](https://github.com/user-attachments/assets/ce3a92b6-ceb7-4858-a26a-78acbc139b57)

# Todo
- [ ] Finalize support for vertical panels (Might take some time).
- [ ] Add representations with "just arrows" (Almost done).
- [ ] Add customization options for highlighting systems (Almost done).
- [ ] Add representations with disappearing items for desktops with no windows (One-liner, should be easy to add).

# Contributing
## New highlight style
Look at the .qml files inside ```contents/ui/highlights/```.

It should be self explanatory, the ```op``` property is manipulated inside the component by a loader to give different styles of highlighting.

To test it, add the path to ```contents/ui/Common/HighlightLoader.qml``` file(should also be self-explanatory).

## New Indicator style
These are stored inside ```contents/ui/representations/```. To test yours, add the path to the switch statement inside ```contents/ui/main.qml```.

- Each indicator is placed at the beginning of the applet. So you need to manipulate the position of each one by using ```x``` and ```y``` properties.
- The parent element has no way of knowing the length of the content you are placing in there, since it is dynamically choosing from representations.
  - There is a ```len``` property inside main.qml for you to keep track of. Add or subtract from it to grow or shrink the size of the parent element, or your representation will overflow/underflow
  - The best way to do this is by adding ```Component.onCompleted``` and ```Component.onDestruction``` signals to keep track of that for you.
  - If your representation is resizable, it is recommended to add ```onWidthChanged``` and ```onHeightChanged``` signals to keep track of the changing size.

## Adding new config options
These will only be added after careful consideration and should not directly be added by the contributor. If you are opening a pull request for a new indicator or highlight style, hard-code the values temporarily.

# Installation
cd into the cloned directory and run ```sh install.sh```.
Or install from the ```Get new widget functionality``` in KDE Plasma.
