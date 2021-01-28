### Generic provisioning
Read [this article](https://medium.com/@tretuna/macbook-pro-web-developer-setup-from-clean-slate-to-dev-machine-1befd4121ba8) about setting up a web dev-MBP and then [this article](https://dev.to/oryanmoshe/i-spend-one-hour-a-week-optimizing-my-development-environment-l9a) about optimising your dev-workflow on the MBP.

First upgrade macOS to latest everything and then
```bash
xcode-select --install
```
then Upgrade macOS to latest everything again.

Add `auth sufficient pam_tid.so` to the top of your `/private/etc/pam.d/sudo` file to be able to use TouchID for sudo.

Next set some system preferences
```bash
# Show library folder
chflags nohidden ~/Library
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles YES
# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

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
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disabling the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use column view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle Clmv

# Avoiding the creation of .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Enabling snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Speeding up Mission Control animations and grouping windows by application
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

# Setting Dock to auto-hide and removing the auto-hiding delay
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float .1

# Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate
defaults write com.apple.dock tilesize -int 36

# Preventing Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable the sudden motion sensor as its not useful for SSDs
sudo pmset -a sms 0

# restart finder to apply finder things
killall Finder
# restart dock to apply dock things
killall Dock

```
Install [homebrew](https://brew.sh)  

### Some apps
```bash
brew install --cask \
authy \
discord \
docker \
dozer \
google-backup-and-sync \
grandperspective \
handbrake \
iina \
intellij-idea \
iterm2  \
numi \
ocenaudio \
signal \
spotify \
transmission \
virtualbox \
visual-studio-code \
visualvm

brew install \
jq \
mas \
telnet \
tldr \
watch \
wget

brew tap filippo.io/age https://filippo.io/age
brew install age

mas install 1477089520 # Backtrack
mas install 668208984  # Giphy capture
mas install 1319778037 # iStat Menus
mas install 441258766  # Magnet
mas install 1480068668 # Messenger
mas install 803453959  # Slack
mas install 1176895641 # Spark
mas install 425424353  # The Unarchiver
mas install 966085870  # Ticktick
mas install 1491071483 # Tot
mas install 1147396723 # WhatsApp
mas install 1320666476 # Wipr
mas install 1451685025 # Wireguard
```
Manually install
* [Ableton Live (login)](https://www.ableton.com/en/live/)
* [Affinity Photo (login)](https://affinity.serif.com/en-gb/photo/)
* [Autodesk Fusion 360 (login)](https://www.autodesk.com/products/fusion-360/overview)
* [Loopback Audio](https://rogueamoeba.com/loopback/)
* [Sketchup (online no install)](https://app.sketchup.com/)
* [Wondershare FilmoraPro](https://filmora.wondershare.com/filmorapro-video-editor/)
* TODO: [LittleSnitch](https://www.obdev.at/products/littlesnitch/index.html)?

### Some quick look plugins
```bash
brew install --cask quicklook-json
```

### Setup the terminal
Follow [this guide](https://gist.github.com/kevin-smets/8568070#file-iterm2-solarized-md) and then add the following plugins to `.zshrc`
* `docker`
* `git`
* [autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh) (needs some reading)
* [syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)

#### Other small things
```bash
cat <<'EOF' >> ~/.zshrc
alias pls="sudo"
alias brewup="brew update; brew upgrade; brew cleanup; brew doctor"
alias ls="ls -haln"

# git
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

# docker
# Delete all stopped containers (including data-only containers)
alias dkrm='for id in $(docker ps -aq -f status=exited); do docker rm -f $id; done'
alias dkkill='for id in $(docker ps -q); do docker kill $id; done'

# Serve the current directory over http
alias serve='python -m SimpleHTTPServer'

alias wget='wget -c'
alias jcurl='curl -H "Content-Type: application/json" -H "Accept: application/json"'

encrypt() {
  age -r "$(cat ${1:-~/.ssh/id_rsa.pub})" -
}

decrypt() {
  age -d -i ${1:-~/.ssh/id_rsa} -
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
```
### Git
```bash
git config --global user.name "Ted Steen"
git config --global user.email "ted.steen@gmail.com"
git config --global color.ui auto
```

#### Java SDKs
See [this thread](https://stackoverflow.com/questions/52524112/how-do-i-install-java-on-mac-osx-allowing-version-switching/52524114#52524114) or just do this
```bash

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

### Node and friends
Install nvm as [oh-my-zsh-plugin](https://github.com/lukechilds/zsh-nvm#as-an-oh-my-zsh-custom-plugin)
Then install latest node
```bash
nvm install node
```
Then add the plugin `npm` to `~/.zshrc`

### React native
 Make sure Node and friends are installed (see above).
```bash
echo "alias react-native='npx react-native'" >> ~/.zshrc
brew install watchman
```
#### iOS SDK
```bash
mas install 497799835 # Xcode
brew install cocoapods
```
#### Android SDK
```bash
brew install --cask android-sdk
echo "export ANDROID_SDK_ROOT='/usr/local/share/android-sdk'" >> ~/.zshrc
source ~/.zshrc
# sdkmanager requires java 8!
javaopenjdk 8
sdkmanager --update
sdkmanager "platform-tools" "platforms;android-30" "system-images;android-29;default;x86_64" "build-tools;30.0.3"
```

### Kubernetes
```bash
# Install in order:
# kubectl - the kubernetes cli
# kubectx - to easily switch between clusters and environments
# helm
# kn - the knative cli
# k3d - to create local clusters
# k9s - Kubernetes CLI To Manage Your Clusters In Style
brew install \
helm \
k3d \
derailed/k9s/k9s \
starkandwayne/kubernetes/knative-client \
kubectl \
kubectx

echo "alias k='kubectl'" >> ~/.zshrc

# Perhaps try out https://github.com/derailed/popeye
```
Then add the plugin `kubectl` to `~/.zshrc`

### Upgrading
```bash
# Oh My Zsh + zsh
omz update
# Oh My Zsh plugins and themes
for file in ~/.oh-my-zsh/custom/*/*/ ; do zsh -c "cd $file; git pull"; done
# Brew
brewup
# App Store
mas upgrade
# Node
nvm install node --reinstall-packages-from=node
# Global node packages
npm update -g
# sdkmanager
javaopenjdk 8
sdkmanager --update
sdkmanager --list #to check what's new
sdkmanager "platform-tools" "platforms;android-XX" "system-images;android-XX;default;x86_64" "build-tools;XX.X.X" # Replace X with newer versions
```