### Generic provisioning
Read [this article](https://medium.com/@tretuna/macbook-pro-web-developer-setup-from-clean-slate-to-dev-machine-1befd4121ba8) about setting up a web dev-MBP and then [this article](https://dev.to/oryanmoshe/i-spend-one-hour-a-week-optimizing-my-development-environment-l9a) about optimising your dev-workflow on the MBP.

First upgrade macOS to latest everything and then
```bash
xcode-select --install
```
then Upgrade macOS to latest everything again.

Next set some system preferences
```bash
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

# Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate
defaults write com.apple.dock tilesize -int 36

# Speeding up Mission Control animations and grouping windows by application
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

# Setting Dock to auto-hide and removing the auto-hiding delay
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

# Preventing Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable the sudden motion sensor as its not useful for SSDs
sudo pmset -a sms 0

# restart finder to apply it all
killall Finder

```
Next install [homebrew](https://brew.sh)  
and then install some fonts for iTerm and other code things
```bash
brew tap homebrew/cask-fonts && brew cask install font-source-code-pro
```

### Some apps
```bash
brew cask install \
atom \
authy \
cyberduck \
google-backup-and-sync \
google-chrome \
grandperspective \
handbrake \
dashlane \
discord \
docker \
iina \
intellij-idea \
iterm2  \
mas \
numi \
ocenaudio \
signal \
slack \
the-unarchiver \
ticktick \
transmission \
spotify \
viscosity \
visualvm

brew install \
jq \
watch \
wget \
telnet \
tldr

brew tap filippo.io/age https://filippo.io/age
brew install age

mas install 1451685025 # Wireguard
mas install 1491071483 # Tot
mas install 1480068668 # Messenger
mas install 1147396723 # WhatsApp
mas install 441258766  # Magnet
mas install 668208984  # Giphy capture
mas install 1319778037 # iStat Menus
```
Manually install
* [Loopback Audio](https://rogueamoeba.com/loopback/)
* [Affinity Photo (login)](https://affinity.serif.com/en-gb/photo/)
* [Ableton Live (login)](https://www.ableton.com/en/live/)
* [Autodesk Fusion 360 (login)](https://www.autodesk.com/products/fusion-360/overview)
* [Sketchup (online no install)](https://app.sketchup.com/)
* [Wondershare FilmoraPro](https://filmora.wondershare.com/filmorapro-video-editor/)

Install the following plugins for atom
 [atom-beautify](https://atom.io/packages/atom-beautify), [busy-signal](https://atom.io/packages/busy-signal), [file-icons](https://atom.io/packages/file-icons), [git-blame](https://atom.io/packages/git-blame), [intentions](https://atom.io/packages/intentions), [linter](https://atom.io/packages/linter), [linter-ui-default](https://atom.io/packages/linter-ui-default), [minimap](https://atom.io/packages/minimap), [markdown-preview-plus](https://atom.io/packages/markdown-preview-plus) and [teletype](https://atom.io/packages/teletype).  
 Then disable the built in `markdown-preview`.

### Some quick look plugins
```bash
brew cask install \
quicklook-json
```

### Setup the terminal
Follow [this guide](https://gist.github.com/kevin-smets/8568070#file-iterm2-solarized-md) and then add the following plugins to `.zshrc`
* `docker`
* [autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh) (needs some reading)

#### Other small things
```bash
cat <<'EOF' >> ~/.zshrc
alias pls="sudo"

# git
alias ls="ls -haln"
alias gs="git status"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit -m"
alias gd="git diff HEAD"
alias go="git push -u origin"
alias gco="git checkout"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# All local branches in the order of their last commit
alias gb="git for-each-ref --sort='-authordate:iso8601' --format=' %(color:green)%(authordate:iso8601)%09%(color:white)%(refname:short)' refs/heads"
alias gnuke="git reset --hard; git clean -fd"

# docker
# Delete all stopped containers (including data-only containers)
alias dkrm='for id in $(docker ps -aq -f status=exited); do docker rm -f $id; done'
alias dkkill='for id in $(docker ps -q); do docker kill $id; done'

alias serve='python -m SimpleHTTPServer'

alias wget='wget -c'
alias jcurl='curl -H "Content-Type: application/json" -H "Accept: application/json"'

alias k='kubectl'

encrypt() {
  age -r "$(cat ${1:-~/.ssh/id_rsa.pub})" -
}

decrypt() {
  age -d -i ${1:-~/.ssh/id_rsa} -
}
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
    brew cask install $CASK
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
brew cask install android-sdk
echo "export ANDROID_SDK_ROOT='/usr/local/share/android-sdk'" >> ~/.zshrc
source ~/.zshrc
# sdkmanager requires java 8!
javaopenjdk 8
sdkmanager --update
sdkmanager "platform-tools" "platforms;android-28" "system-images;android-28;default;x86_64" "build-tools;28.0.3"
```

### Kubernetes
```bash
# Install in order:
# kubectl - the kubernetes cli
# kubectx - to easily switch between clusters and environments
# helm
# kn - the knative cli
# #minikube - to create local clusters
# k3d - to create local clusters
# k9s - Kubernetes CLI To Manage Your Clusters In Style
brew install \
kubectl \
kubectx \
helm \
starkandwayne/kubernetes/knative-client \
#minikube \
k3d \
derailed/k9s/k9s

# Perhaps try out https://github.com/derailed/popeye
```
Then add the plugin `kubectl` to `~/.zshrc`
