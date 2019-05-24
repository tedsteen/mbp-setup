# My environment

provisioning
```bash
echo "Install https://www.iterm2.com/"

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.bash_profile
brew update
brew upgrade

brew install git

git config --global user.name "Ted Steen"
git config --global user.email "ted.steen@gmail.com"
git config --global color.ui auto

brew install docker
brew install docker-machine

brew install bash-completion
#Before doing the following bash-completion stuff check if it already works..
echo "[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion" >> ~/.bash_profile
ln -s /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion /usr/local/etc/bash_completion.d/docker
ln -s /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion /usr/local/etc/bash_completion.d/docker-machine
ln -s /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion /usr/local/etc/bash_completion.d/docker-compose

echo "export BLOCKSIZE=1k" >> ~/.bash_profile

echo "alias ls='ls -hal'" >> ~/.bash_profile
echo "alias mkdir='mkdir -pv'" >> ~/.bash_profile

curl -s "https://get.sdkman.io" | bash
sdk i java
launchctl setenv JAVA_HOME ~/.sdkman/candidates/java/current
```
