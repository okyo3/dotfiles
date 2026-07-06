# How To Use For Mac

```sh
xcode-select --install

ssh-keygen -t ed25519 -C "your mail address"

echo "[user]
  name = okyo3
  email = your GitHub mail address
" > $HOME/.gitconfig

cd $HOME/dotfiles
./script/mac/setup.sh
./script/mac/ln.sh
mise install
./script/mac/settings.sh
```

# Remarks
* Files for local settings
    * .zshrc.local
    * .gitconfig.local
