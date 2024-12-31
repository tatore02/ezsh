#!/bin/bash

if ! command -v zsh &> /dev/null; then
    echo "Installing ZSH..."
    sudo pacman -S --noconfirm zsh
else
    echo "ZSH is already installed."
fi

echo "Installing Oh-my-ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

if ! fc-list | grep -qi "MesloLGS NF"; then
    echo "Installing nerd-fonts..."
    sudo pacman -S --noconfirm ttf-meslo-nerd
    fc-cache -fv
else
    echo "Nerd-fonts are already installed."
fi

echo "Installing Powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

zsh
echo "Please follow the on-screen instructions to configure Powerlevel10k."

echo "Installing Zinit..."
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
zinit self-update

echo "Adding plugins to ZSHRC..."
echo "zinit light zdharma-continuum/fast-syntax-highlighting" >> ~/.zshrc
echo "zinit light zsh-users/zsh-autosuggestions" >> ~/.zshrc
echo "zinit snippet OMZP::sudo" >> ~/.zshrc
echo "zinit snippet OMZP::dirhistory" >> ~/.zshrc

zsh
