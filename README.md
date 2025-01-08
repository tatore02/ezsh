# EZSH

## Automatic Script
**ALERT: It works only on arch-based distros**
```bash
git clone https://github.com/tatore02/ezsh.git
cd ezsh
chmod +x install.sh
./install.sh
```

## Manual
### Install ZSH
See this [guide](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH).
### Install Oh-my-ZSH
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"```
### Download nerd-fonts
```bash
curl --remote-name-all https://github.com/romkatv/powerlevel10kmedia/raw/master/{MesloLGS%20NF%20Regular.ttf,MesloLGS%20NF%20Bold.ttf,MesloLGS%20NF%20Italic.ttf,MesloLGS%20NF%20Bold%20Italic.ttf}
```
### Install nerd-fonts
```bash
mkdir -p ~/.fonts
mv -n MesloLGS\ NF\ Bold\ Italic.ttf MesloLGS\ NF\ Bold.ttf MesloLGS\ NF\ Italic.ttf MesloLGS\ NF\ Regular.ttf ~/.fonts
fc-cache -fv
```
### Powerlevel10k
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
zsh
```

### Install Zinit
```bash
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
zinit self-update
```
### Plugins
#### Syntax highlighting
```bash
echo "zinit light zdharma-continuum/fast-syntax-highlighting" >> ~/.zshrc
zsh
```
#### Autosuggestions
```bash
echo "zinit light zsh-users/zsh-autosuggestions" >> ~/.zshrc
zsh
```
#### Sudo
```bash
echo "zinit snippet OMZP::sudo" >> ~/.zshrc
zsh
```
#### Dirhistory
```bash
echo "zinit snippet OMZP::dirhistory" >> ~/.zshrc
zsh
```

