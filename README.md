# README

## Setting up a new Mac

0. Install Xcode (download directly from developer site)

0. Install 1password
    - Connect to iCloud

0. Create ssh key

    - `ssh-keygen -t ed25519`
    - Add public key to Github

0. Set up environment

    ```
    git clone git@github.com:michael-yx-wu/environment.git
    cd environment
    ./install_dev_tools_and_setup.sh
    ```

0. Install iTerm2

    - Load preferences from `com.googlecode.iterm2.plist` in this repo

0. Install BetterTouchTool

    - Import license from 1password
    - Load preferences from `btt.json` in this repo

0. Set hostname

0. Install [Fira Code](https://github.com/tonsky/FiraCode)