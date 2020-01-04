# My environment

## generic provisioning
# Read https://medium.com/@tretuna/macbook-pro-web-developer-setup-from-clean-slate-to-dev-machine-1befd4121ba8
# and https://dev.to/oryanmoshe/i-spend-one-hour-a-week-optimizing-my-development-environment-l9a
# and then basically do the following..

# Upgrade macOS to latest everything
xcode-select --install
# Upgrade macOS to latest everything again

# Install homebrew
# https://brew.sh

# Fonts for iterm2 and other code things
brew tap homebrew/cask-fonts && brew cask install font-source-code-pro

# Apps
brew cask install \
alfred \
atom \
bettertouchtool \
google-backup-and-sync \
google-chrome \
dashlane \
discord \
docker \
intellij-idea \
iterm2  \
signal \
slack \
ticktick \
transmission \
spotify \
viscosity \
vlc

# Quick look plugins
brew cask install \
qlcolorcode \
qlstephen \
qlmarkdown \
quicklook-json \
qlprettypatch \
quicklook-csv \
webpquicklook \
suspicious-package

# Follow this guide https://gist.github.com/kevin-smets/8568070#file-iterm2-solarized-md
# and then add docker to .zshrc plugins

git config --global user.name "Ted Steen"
git config --global user.email "ted.steen@gmail.com"
git config --global color.ui auto

# Java SDKs
# see https://stackoverflow.com/questions/52524112/how-do-i-install-java-on-mac-osx-allowing-version-switching/52524114#52524114
# But in the end it's this:

brew tap adoptopenjdk/openjdk && brew cask install \
adoptopenjdk8 \
adoptopenjdk11 \
adoptopenjdk13

# To list all available versions
/usr/libexec/java_home -V

# Make it easy to switch
echo "alias java8='export JAVA_HOME=$(/usr/libexec/java_home -v1.8)'" >> ~/.zshrc
echo "alias java11='export JAVA_HOME=$(/usr/libexec/java_home -v11)'" >> ~/.zshrc
echo "alias java13='export JAVA_HOME=$(/usr/libexec/java_home -v13)'" >> ~/.zshrc
# Default to Java 13
echo "java13" >> ~/.zshrc
source ~/.zshrc

## React native
```bash
yarn global add react-native-cli
# setup android sdk
```

## Android sdk
```bash
brew cask install android-sdk
echo "export ANDROID_HOME=/usr/local/share/android-sdk" >> ~/.zshrc
source ~/.bash_profile

sdkmanager --update
sdkmanager "platform-tools" "platforms;android-28"
```
