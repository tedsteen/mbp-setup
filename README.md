### Generic provisioning
Read [this article](https://medium.com/@tretuna/macbook-pro-web-developer-setup-from-clean-slate-to-dev-machine-1befd4121ba8) about setting up a web dev-MBP and then [this article](https://dev.to/oryanmoshe/i-spend-one-hour-a-week-optimizing-my-development-environment-l9a) about optimising your dev-workflow on the MBP.

First upgrade macOS to latest everything and then
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
atom \
authy \
google-backup-and-sync \
google-chrome \
handbrake \
dashlane \
discord \
docker \
iina \
intellij-idea \
iterm2  \
ocenaudio \
signal \
slack \
ticktick \
transmission \
spotify \
viscosity \
visualvm

brew install \
jq \
watch \
wget

brew tap filippo.io/age https://filippo.io/age
brew install age
```
Manually install
* [Giphycapture](https://giphy.com/apps/giphycapture)
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
qlcolorcode \
qlstephen \
qlmarkdown \
quicklook-json \
webpquicklook

# If there is trouble with permissions do this (see https://github.com/anthonygelibert/QLColorCode/issues/51#issuecomment-563982425)
xattr -d com.apple.quarantine ~/Library/QuickLook/QLColorCode.qlgenerator
xattr -d com.apple.quarantine ~/Library/QuickLook/QLStephen.qlgenerator
xattr -d com.apple.quarantine ~/Library/QuickLook/QLMarkdown.qlgenerator
xattr -d com.apple.quarantine ~/Library/QuickLook/WebpQuickLook.qlgenerator
# And to be sure it is applied do
killall Finder
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
brew tap adoptopenjdk/openjdk

# To list all available versions
/usr/libexec/java_home -V

# Make it easy to switch and check version
cat <<'EOF' >> ~/.zshrc
alias javav='java -version'

chjava() {
  JHOME=/Library/Java/JavaVirtualMachines/$1/Contents/Home
  CASK=$2
  if [ ! -d "$JHOME" ]; then
    echo "Java $CASK is not installed, installing..."
    brew cask install $CASK
  fi
  export JAVA_HOME=$JHOME
  java -version
}

alias java8='chjava adoptopenjdk-8.jdk adoptopenjdk8'
alias java9='chjava adoptopenjdk-9.jdk adoptopenjdk9'
alias java10='chjava adoptopenjdk-10.jdk adoptopenjdk10'
alias java11='chjava adoptopenjdk-11.jdk adoptopenjdk11'
alias java12='chjava adoptopenjdk-12.jdk adoptopenjdk12'
alias java13='chjava adoptopenjdk-13.jdk adoptopenjdk13'
alias java14='chjava adoptopenjdk-14.jdk adoptopenjdk14'
alias java15='chjava adoptopenjdk-15.jdk adoptopenjdk15'

# Default to Java 14
java14
EOF

# If you want zulu https://github.com/mdogan/homebrew-zulu
brew tap mdogan/zulu

cat <<'EOF' >> ~/.zshrc
alias javazulu8='chjava zulu-8.jdk zulu-jdk8'
alias javazulu11='chjava zulu-11.jdk zulu-jdk11'
alias javazulu12='chjava zulu-12.jdk zulu-jdk12'
alias javazulu13='chjava zulu-13.jdk zulu-jdk13'
alias javazulu14='chjava zulu-14.jdk zulu-jdk14'
alias javazulu15='chjava zulu-15.jdk zulu-jdk15'
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
Install [Xcode](https://apps.apple.com/us/app/xcode/id497799835) and then
```bash
brew install cocoapods
```
#### Android SDK
```bash
brew cask install android-sdk
echo "export ANDROID_SDK_ROOT='/usr/local/share/android-sdk'" >> ~/.zshrc
source ~/.zshrc
# sdkmanager requires java8!
java8
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
