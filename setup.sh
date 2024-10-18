#!/bin/bash
set -e

# Configure CLI
touch ~/.hushlogin

# Copy dot files to home directory, skipping .DS_Store
for filename in dot_files/.*; do
  [[ -e "${filename}" ]] || continue
  [[ "${filename}" != "dot_files/.DS_Store" ]] || continue
  cp -v "${filename}" "~/"
done

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Starship prompt
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

# Install CLI tools using Homebrew
/opt/homebrew/bin/brew install starship

# Install zsh plugins
git clone https://github.com/marlonrichert/zsh-autocomplete.git "${HOME}/.zsh-plugins/zsh-autocomplete"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${HOME}/.zsh-plugins/zsh-syntax-highlighting"

# Install GUI apps using Homebrew Cask
/opt/homebrew/bin/brew install --cask brave-browser raycast transmission iina visual-studio-code

# Set OSX System preferences
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain AppleShowScrollBars -string WhenScrolling
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
defaults write com.apple.dock "show-recents" -int 0
defaults write com.apple.dock "minimize-to-application" -int 1
defaults write com.apple.dock "tilesize" -int 34
defaults write com.apple.dock "orientation" -string "left"
defaults write com.apple.TextEdit NSShowAppCentricOpenPanelInsteadOfUntitledFile -bool false
killall Dock
sudo killall Finder

# Set login window message to with instructions for returning the computer
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "—ฅ/ᐠ. <032b> .ᐟ\\\ฅ— if it is lost, pls return this computer to lost@jul.sh"

# Setup launch agents
(cd launchagent_remap_capslock_to_backspace && /bin/bash setup.sh)

echo "All done! Pls see the manual_taks dir for remaining manual setup tasks."
