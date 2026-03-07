```sh
./script/mac/settings.sh

xcode-select --install

ssh-keygen -t ed25519 -C "your mail address"

echo "[user]
  name = okyo3
  email = your GitHub mail address
" > $HOME/.gitconfig

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
./script/mac/brew.sh

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
./script/share/rust.sh

cd $HOME/dotfiles
./script/mac/ln.sh
```
