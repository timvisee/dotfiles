# Tim does dotfiles
dotfiles are used to personalize your system and applications. These are mine.

## Requirements
* Linux or Mac OS X
* `git`
* `bash`
* When using Vim, [Vundle](https://github.com/VundleVim/Vundle.vim) must be installed.

## Recommendations
* `awesomeWM`: tiling window manager, additional dependencies
    * `awesome`: window manager itself
    * `awesome-extra`: additional libraries used in my configuration
    * `i3lock-color-git`: [[link]](https://github.com/chrjguill/i3lock-color) fancy and customizable lock screen
    * `xautolock`: lock screen when inactive
    * `libnotify-bin`: notification handling
* `xcape` (Linux): to bind <kbd>Caps Lock</kbd> to <kbd>Esc</kbd>.
* `fish`: as better shell
* `thefuck`: for handy incorrect command fixes.

## Installation
An installation script is included to easily install the dotfiles on your system.

On Linux or Mac OS X, use:
```
git clone https://github.com/timvisee/dotfiles.git ~/dotfiles
cd ~/dotfiles
sudo chmod a+x ./install
./install
```

To install all Vim plugins, first make sure [Vundle](https://github.com/VundleVim/Vundle.vim) is installed.  
Then, run the `:PluginInstall` command in Vim.

## License
This project is released under the GNU GPL-3.0 license. Check out the [LICENSE](LICENSE) file for more information.
