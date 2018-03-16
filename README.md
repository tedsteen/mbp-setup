# My environment

provisioning
```bash
echo "Install https://www.iterm2.com/"

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo 'export PATH="/usr/local/sbin:$PATH"' >> ~/.bash_profile
brew update
brew upgrade

brew install bash-completion
echo "[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion" >> ~/.bash_profile

brew install git

git config --global user.name "Ted Steen"
git config --global user.email "ted.steen@gmail.com"
git config --global color.ui auto

brew install docker
brew install docker-machine

echo "export BLOCKSIZE=1k" >> ~/.bash_profile


echo "alias ls='ls -hal'" >> ~/.bash_profile
echo "alias mkdir='mkdir -pv'" >> ~/.bash_profile



```
