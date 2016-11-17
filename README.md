# README

## Setting up a new Mac

0. Install Xcode (download directly from developer site)

0. Enable password-less `sudo`

0. Install 1password
    - Import license from Google Drive
    - Connect to iCloud

0. Install Fliqlo and hot corner bottom left corner to screen saver

0. Create ssh key

    - `ssh-keygen -t rsa -b 4096`
    - Add public key to Github

0. Create Github Personal Access Token and export value as `HOMEBREW_GIHUB_API_TOKEN` in `~/.bash_profile`

    - Uncheck all scopes

0. Install homebrew

    - Check homebrew website for latest installation bootstrap instructions
    - `brew install bash vim rbenv pyenv`

0. Install scripts

    ```
    git clone git@github.com:michael-yx-wu/branch-maid.git
    git clone git@github.com:michael-yx-wu/dockerclean.git
    ```

0. Set up environment

    ```
    git clone git@github.com:michael-yx-wu/environment.git
    cd environment
    ./environment.rb -i
    ./environment.rb -s
    ```

0. Install iTerm2

    - Install shell integration
    - load preferences from this repository

0. Install BetterTouchTool

    - Import license from Google Drive
    - Import `btt.prefs`

0. Set hostname

## Setting up Palantir Mac

0. Register new public key with sites as necessary

0. Install Dash

0. Create Github Enterprise Personal Access Token and export value as `GHE_TOKEN` in `~/.bash_profile`

    - Check the `repo` scope
