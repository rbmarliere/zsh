# zshrc

To use it, make sure you point your own .zshrc to it, e.g.:

```sh
mkdir -p ~/git
git clone --recursive https://github.com/zrts/zsh.git ~/git/zsh
mv ~/.zshrc ~/.zshrc_old
ln -s ~/git/zsh/zshrc ~/.zshrc
source ~/.zshrc
envset
```


