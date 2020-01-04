### Generic provisioning
Read [this article](https://medium.com/@tretuna/macbook-pro-web-developer-setup-from-clean-slate-to-dev-machine-1befd4121ba8) about setting up a web dev-MBP and then [this article](https://dev.to/oryanmoshe/i-spend-one-hour-a-week-optimizing-my-development-environment-l9a) about optimising your dev-workflow on the MBP.

First upgrade macOS to latest everything then
```bash
xcode-select --install
```
then Upgrade macOS to latest everything again.

Next install [homebrew](https://brew.sh)  
and then install some fonts for iTerm and other code things
```bash
brew tap homebrew/cask-fonts && brew cask install font-source-code-pro
```

### Some apps
```bash
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
```
### Some quick look plugins
```bash
brew cask install \
qlcolorcode \
qlstephen \
qlmarkdown \
quicklook-json \
qlprettypatch \
quicklook-csv \
webpquicklook \
suspicious-package
```
### Setup the terminal
Follow [this guide](https://gist.github.com/kevin-smets/8568070#file-iterm2-solarized-md) and then add docker to `.zshrc` plugins.

### Git
```bash
git config --global user.name "Ted Steen"
git config --global user.email "ted.steen@gmail.com"
git config --global color.ui auto
```

#### Java SDKs
See [this thread](https://stackoverflow.com/questions/52524112/how-do-i-install-java-on-mac-osx-allowing-version-switching/52524114#52524114) or just do this
```bash
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
# Restart the terminal or
source ~/.zshrc
```

### React native
```bash
yarn global add react-native-cli
# setup android sdk
```

### Android sdk
```bash
brew cask install android-sdk
echo "export ANDROID_HOME=/usr/local/share/android-sdk" >> ~/.zshrc
source ~/.bash_profile

sdkmanager --update
sdkmanager "platform-tools" "platforms;android-28"
```
