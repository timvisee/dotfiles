# Tim does dotfiles
dotfiles are used to personalize your system and applications. These are mine.

## Requirements
* Linux or Mac OS X
* `git`
* `bash`
* When using Vim, [vim-plug][vim-plug] is installed.

## Recommendations
* `alacritty`: awesome terminal emulator
* `bspwm`: tiling window manager, additional dependencies
    * `sxhkd`: shortcut daemon
    * `polybar`: desktop bar
    * `dunst`: notification daemon
* `awesomeWM`: tiling window manager, additional dependencies
    * `awesome`: window manager itself
    * `awesome-extra`: additional libraries used in my configuration
    * `i3lock-color-git`: [[link]](https://github.com/chrjguill/i3lock-color) fancy and customizable lock screen
    * `xautolock`: lock screen when inactive
    * `libnotify-bin`: notification handling
* `rust` nightly: for proper language completion in Vim, through `rustup`
* `xcape` (Linux): to bind <kbd>Caps Lock</kbd> to <kbd>Esc</kbd>.
* `keychain`: for SSH key management
* `fish`: as better shell
* `starship`: as better shell prompt
* `thefuck`: for handy incorrect command fixes
* `highlight`: for syntax highlighting in ranger

## Installation
An installation script is included to easily install the dotfiles on your system.

On Linux or Mac OS X, use:
```bash
# Clone the repository
git clone https://github.com/timvisee/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install
sudo chmod a+x ./install
./install
```

Vim plugins should be installed automatically, the `:PlugInstall` command may be
used to force.

### Alacritty
This configuration recommends [`alacritty`][alacritty] as default terminal.
First, install it as stated on it's GitHub page.
Then configure it as default terminal using:
```bash
# Add alacritty to the terminal list
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which alacritty) 0

# Select the default terminal
sudo update-alternatives --config x-terminal-emulator
```

## ErgoDox
This repository includes my ErgoDox keyboard layout configuration,
located in the [ergodox](./ergodox) directory.

![ErgoDox layout](./ergodox/layout.png)

## Hosts blacklist
This repository includes my personal hosts banlist.
The up-to-date raw file can be accessed via
[`https://gitlab.com/timvisee/dotfiles/raw/master/hosts/blacklist.txt`](https://gitlab.com/timvisee/dotfiles/raw/master/hosts/blacklist.txt).

## License
This project is released under the GNU GPL-3.0 license. Check out the [LICENSE](LICENSE) file for more information.

[alacritty]: https://github.com/jwilm/alacritty
[vim-plug]: https://github.com/junegunn/vim-plug
