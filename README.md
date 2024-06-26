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

```

Based on many things but most recently [this article](https://betterprogramming.pub/how-to-set-up-your-macbook-for-web-development-in-2021-a7a1f53f6462).


Set some system preferences

```bash
# Make it possible to authenticate with Touch ID for sudo
sudo -- sh -c 'echo "auth sufficient pam_tid.so\n$(cat /etc/pam.d/sudo)" > /etc/pam.d/sudo'

# Show library folder
# chflags nohidden ~/Library

# Show hidden files
# defaults write com.apple.finder AppleShowAllFiles YES

# Keyboard repeat and delay speeds
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Expanding the save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Setting trackpad & mouse speed to a reasonable number
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

# Showing all filename extensions in Finder by default
# defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disabling the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use column view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle Clmv

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
# Install latest zsh
brew install zsh
# Allow to use homebrews zsh as shell
echo "/opt/homebrew/bin/zsh" | sudo tee -a /etc/shells > /dev/null
# Switch to new zsh
chsh -s /opt/homebrew/bin/zsh

brew install powerlevel10k
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc

brew install zsh-syntax-highlighting
echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

brew install zsh-autosuggestions
echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

brew install zsh-history-substring-search
echo "source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh" >> ~/.zshrc
# Make up/down arrows work
echo "bindkey '^[[A' history-substring-search-up && bindkey '^[[B' history-substring-search-down" >> ~/.zshrc

# Enable autocomplete
echo "autoload -Uz compinit && compinit" >> ~/.zshrc
# Allow comments in the command line
echo "setopt interactivecomments" >> ~/.zshrc

cat <<'EOF' >> ~/.zshrc
# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
EOF

# Now restart the terminal
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
rectangle \
signal \
spotify \
stats \
transmission \
visual-studio-code \
workflowy

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

# mas install 1477089520 # Backtrack
mas install 1370791134 # DigiDoc4 Client
mas install 1480068668 # Messenger
# mas install 1529448980 # Reeder
# mas install 1176895641 # Spark
mas install 425424353  # The Unarchiver
mas install 966085870  # Ticktick
mas install 1147396723 # WhatsApp
# mas install 1320666476 # Wipr
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

# Forward to remote docker.
# `dkfw user@machine` to forward to remote machine
# Use `dkfw stop` to revert to local
dkfw() {
  host=${1:-ted@marati.s3n.io}
  if [ "$host" = "stop" ] ; then
    if [ ! -z "$DOCKER_FW_SSH_PID" ] ; then kill $DOCKER_FW_SSH_PID; fi
    rm -f /tmp/docker-fw.sock
    unset DOCKER_HOST
    unset DOCKER_FW_SSH_PID
    return 0
  fi

  if [ -z "$DOCKER_FW_SSH_PID" ]; then
    ssh -L /tmp/docker-fw.sock:/var/run/docker.sock $host -oStrictHostKeyChecking=no -N &
    export DOCKER_FW_SSH_PID=$!
    export DOCKER_HOST=unix:///tmp/docker-fw.sock
  fi
}

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

dev-here() {
  lang=$1
  port=${2:-8000}

  if [ "$lang" = "" ]; then
      echo 'usage is dev-here <container name> [port:8000] [extra docker args]'
      return 1
  fi

  msg="$lang opening port $port running bash"
  echo $msg
  args=$3
  cmd="docker run --rm -it -p ${port}:${port} -v ${PWD}:/code -w /code $args $lang bash"
  echo $cmd
  eval $cmd
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
brew install fceux
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
brew install michaeleisel/zld/zld

# Wasm stuff
brew install wasm-pack

# Install latest llvm (for better compatability with rusts newer version)
brew install llvm
echo 'export PATH="/opt/homebrew/opt/llvm/bin:$PATH"' >> ~/.zshrc
```

### Java and the SDKs

See [this thread](https://stackoverflow.com/questions/52524112/how-do-i-install-java-on-mac-osx-allowing-version-switching/52524114#52524114) or just do this

```bash
# Install visualvm
brew install --cask visualvm

# To list all available versions
/usr/libexec/java_home -V

# Make it easy to switch and check version
cat <<'EOF' >> ~/.zshrc
alias javav='echo JAVA_HOME=$JAVA_HOME && ls -l /Library/Java/JavaVirtualMachines/current && java -version'
alias javavv='/usr/libexec/java_home -V'
__chjava() {
  TAP=$1
  if [ ! -z "$(brew tap-info $TAP | grep 'Not installed')" ]; then
    brew tap $TAP
  fi

  export JAVA_HOME=/Library/Java/JavaVirtualMachines/$2/Contents/Home
  CASK=$3
  if [ ! -d "$JAVA_HOME" ]; then
    echo "Java $CASK is not installed, installing..."
    brew install --cask $CASK
  fi

  if [ "$4" = "global" ]; then
    sudo ln -sfn $JAVA_HOME /Library/Java/JavaVirtualMachines/current
  fi
  javav
}

javaopenjdk() {
  __chjava adoptopenjdk/openjdk adoptopenjdk-$1.jdk adoptopenjdk$1 $2
}

javazulu() {
  __chjava mdogan/zulu zulu-$1.jdk zulu-jdk$1 $2
}

export JAVA_HOME=/Library/Java/JavaVirtualMachines/current
EOF

# Restart the terminal or
source ~/.zshrc
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
# Python
python -m pip install --upgrade pip; pip-review --local --auto; \
```
