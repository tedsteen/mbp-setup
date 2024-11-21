# Provision my MacBook Pro
This file contains the steps I take to provision my MacBook Pro. It is a work in progress and will change over time.

## Generic provisioning

Getting up and running

```bash
# Get the Svorak keyboard layout in place
sudo curl -L "https://github.com/tedsteen/mbp-setup/raw/master/Swedish-Svorak.keylayout" -o "/Library/Keyboard Layouts/Swedish-Svorak.keylayout"
 
# Setup the random SSH key
mkdir -m 700 ~/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFsgdn22Z0Y4yMT2TITZ3KzkGcmZR2Uc3TDzLp9wr4P1 ted@random" > ~/.ssh/random.pub; chmod 644 ~/.ssh/random.pub
touch ~/.ssh/random; chmod 600 ~/.ssh/random
ssh-add ~/.ssh/random

# Configure ssh to store passwords in keychain and add the random key as default
cat <<'EOF' >> ~/.ssh/config
Host *
  IgnoreUnknown UseKeychain
  UseKeychain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/random
  IdentitiesOnly yes
EOF

# Upgrade macOS to latest everything
softwareupdate --all --install --force
# Install developer tools
xcode-select --install
# Upgrade macOS to latest everything again just to be sure...
softwareupdate --all --install --force

#Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Better terminal
brew install --cask iterm2

# Git config
git config --global user.name "Ted Steen"
git config --global user.email "ted.steen@gmail.com"
git config --global color.ui auto
git config --global pull.rebase false
git config --global fetch.prune true
git config --global push.autoSetupRemote true
```

Set some system preferences

```bash
# Make it possible to authenticate with Touch ID for sudo
sudo -- sh -c 'echo "auth sufficient pam_tid.so\n$(cat /etc/pam.d/sudo)" > /etc/pam.d/sudo'

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Disabling the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoiding the creation of .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Speeding up Mission Control animations and grouping windows by application
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

# Enable App Exposé
# Swipe down with three/four fingers
defaults write com.apple.dock showAppExposeGestureEnabled -bool true

# Enable `Tap to click`
defaults write com.apple.AppleMultitouchTrackpad.plist Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Setting Dock to auto-hide and removing the auto-hiding delay
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float .5

# Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate
defaults write com.apple.dock tilesize -int 36

# Preventing Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable gamepad controller mapped to Launchpad
defaults write com.apple.GameController bluetoothPrefsMenuLongPressAction -integer 0

# restart finder to apply finder things
killall Finder
# restart dock to apply dock things
killall Dock
```

## Setup the terminal

```bash
# Get a nice font and install in iTerm2
https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/0xProto.zip

brew install starship
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# Install zinit
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

echo "zinit light zdharma-continuum/fast-syntax-highlighting" >> ~/.zshrc
echo "zinit light zsh-users/zsh-autosuggestions" >> ~/.zshrc
echo "zinit light marlonrichert/zsh-autocomplete" >> ~/.zshrc
echo "zinit light MichaelAquilina/zsh-you-should-use" >> ~/.zshrc
echo "zinit light zsh-users/zsh-history-substring-search" >> ~/.zshrc
# Make up/down arrows for zsh-history-substring-search work
echo "bindkey '^[[A' history-substring-search-up && bindkey '^[[B' history-substring-search-down" >> ~/.zshrc
echo "setopt interactivecomments" >> ~/.zshrc

# Some git aliases
cat <<'EOF' >> ~/.zshrc
alias gs="git status"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit -m"
alias gd="git diff HEAD"
alias go="git push -u origin"
alias gco="git checkout"
# Pretty git log
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# All local branches in the order of their last commit
alias gb="git for-each-ref --sort='-authordate:iso8601' --format=' %(color:green)%(authordate:iso8601)%09%(color:white)%(refname:short)' refs/heads"
alias gnuke="git reset --hard; git clean -fd"
EOF

# Now restart the terminal or run
source ~/.zshrc
```

## Some apps

```bash
brew install --cask \
arc \
discord \
docker \
balenaetcher \
google-drive \
grandperspective \
handbrake \
iina \
iterm2  \
mullvadvpn \
numi \
ocenaudio \
signal \
spotify \
stats \
transmission \
visual-studio-code \
whisky

brew install \
age \
docker-compose \
fswatch \
jq \
mas \
svtplay-dl ffmpeg \
telnet \
tldr \
watch \
wget

mas install 1370791134 # DigiDoc4 Client
mas install 1480068668 # Messenger
mas install 425424353  # The Unarchiver
mas install 966085870  # Ticktick
mas install 310633997 # WhatsApp
mas install 1451685025 # Wireguard
# mas install 1497506650 # Yubico Authenticator
```

## Manually install

* [Ableton Live (login)](https://www.ableton.com/en/live/)
* [Affinity Photo (login)](https://affinity.serif.com/en-gb/photo/)
* [Autodesk Fusion 360 (login)](https://www.autodesk.com/products/fusion-360/overview)
* [Loopback Audio](https://rogueamoeba.com/loopback/)
* [Sketchup (online no install)](https://app.sketchup.com/)
* [Wondershare FilmoraPro](https://filmora.wondershare.com/filmorapro-video-editor/)
* [Gifox](https://gifox.app/)
* TODO: [LittleSnitch](https://www.obdev.at/products/littlesnitch/index.html)?

## Some quick look plugins

```bash
brew install --cask quicklook-json
```

### Other small things

```bash
cat <<'EOF' >> ~/.zshrc
alias ls="ls -haln"

# docker
# Delete all stopped containers (including data-only containers)
alias dkrm='for id in $(docker ps -aq -f status=exited); do docker rm -f $id; done'
alias dkkill='for id in $(docker ps -q); do docker kill $id; done'

# Serve the current directory over http
alias serve='python -m http.server'

alias wget='wget -c'
alias jcurl='curl -H "Content-Type: application/json" -H "Accept: application/json"'

encrypt() {
  age -r "$(cat ${1:-~/.ssh/random.pub})" -
}

decrypt() {
  age -d -i ${1:-~/.ssh/random} -
}

make_key() {
  name=$1
  kdfs=${2:-100}
  type=${3:-ed25519}
  keyfilename=~/.ssh/$name
  
  ssh-keygen -a $kdfs -t $type -f $keyfilename -C "${name}"
}

make_key_yubikey() {
    name=$1_yubikey_$2
    kdfs=${3:-100}
    keyfilename=~/.ssh/$name
    ssh-keygen -a $kdfs -t ed25519-sk -f $keyfilename -C "${name}"
}

EOF
```

## Python

```bash
brew install pyenv
pyenv install --list # See available versions
pyenv install <version>
pyenv global <version> # Set global version
echo -e '
export PYENV_ROOT="$HOME/.pyenv" 
export PATH="$PYENV_ROOT/bin:$PATH" 
eval "$(pyenv init --path)" 
eval "$(pyenv init -)"
' >> ~/.zshrc

pip install pip-review
```

## Ruby

```bash
brew install rbenv
rbenv install <version>
rbenv global <version>
echo 'eval "$(rbenv init -)"' >> ~/.zshrc
```

## NES Dev

```bash
brew install cc65
echo "Install mesen2 here: https://github.com/SourMesen/Mesen2"
```

## Rust

```bash
curl https://sh.rustup.rs -sSf | sh

# Rust analyser - Details [here](https://rust-analyzer.github.io/manual.html#installation)
rustup component add rust-src
# Install [rust-analyzer](https://github.com/rust-analyzer/rust-analyzer/tree/master/editors/code) in VSCode
open https://marketplace.visualstudio.com/items?itemName=matklad.rust-analyzer

# linter
rustup component add clippy

# Debugging
open https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb

# Instrumentation & profiling
brew install cargo-instruments

# faster linking
#brew install michaeleisel/zld/zld

# Wasm stuff
#brew install wasm-pack

# Install latest llvm (for better compatability with rusts newer version)
#brew install llvm
#echo 'export PATH="/opt/homebrew/opt/llvm/bin:$PATH"' >> ~/.zshrc
```

## Node

```bash
brew install node
```

## Upgrading

```bash
# MacOS stuff
softwareupdate --all --install --force; \
# Brew
brew update; brew upgrade; brew cleanup; brew doctor; \
# Ruby
#gem update; gem update --system; \
# App Store
mas upgrade; \
# Rust
rustup self update; rustup update; \
# Node
npm update -g; \
# Zinit
zinit self-update; zinit update --all; \
# Python
python -m pip install --upgrade pip; pip-review --local --auto; \
```
