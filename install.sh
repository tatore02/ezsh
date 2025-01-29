#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

source detect_distro.sh

if ! command -v zsh &> /dev/null; then
    echo "Installing ZSH..."
    distro=$(detect_distro | tr '[:upper:]' '[:lower:]')

    if [[ "$distro" =~ "arch linux" || "$distro" =~ "manjaro" || "$distro" = "endeavour" ]]; then
        pacman -S --noconfirm zsh

    elif [[ "$distro" =~ "ubuntu" || "$distro" =~ "debian" || "$distro" =~ "mint" || "$distro" =~ "pop" || "$distro" =~ "elementary" ]]; then
        apt -y install zsh

    elif [[ "$distro" = "fedora" ]]; then
        dnf install --assumeyes zsh

    elif [[ "$distro" = "centos" || "$distro" = "rocky" || "$distro" = "alma" || "$distro" = "rhel" ]]; then
        yum -y install zsh

    elif [[ "$distro" = "opensuse" || "$distro" = "sles" ]]; then
        zypper -n install zsh

    else
        echo "Distro not supported"
        exit 1
    fi
else
    echo "ZSH is already installed."
fi

if command -v zsh >/dev/null 2>&1; then
    chsh -s "$(which zsh)"
fi

echo "Installing Oh-my-ZSH..."
echo "y" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing nerd-fonts..."
mkdir -p ~/.fonts
curl --remote-name-all https://github.com/romkatv/powerlevel10k-media/raw/master/{MesloLGS%20NF%20Regular.ttf,MesloLGS%20NF%20Bold.ttf,MesloLGS%20NF%20Italic.ttf,MesloLGS%20NF%20Bold%20Italic.ttf}
mv -n MesloLGS\ NF\ Bold\ Italic.ttf MesloLGS\ NF\ Bold.ttf MesloLGS\ NF\ Italic.ttf MesloLGS\ NF\ Regular.ttf ~/.fonts
fc-cache -fv &> /dev/null

echo "Installing Powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

echo "Installing Zinit..."
echo "y" | bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

echo "Adding plugins to ZSHRC..."
echo "zinit light zdharma-continuum/fast-syntax-highlighting" >> ~/.zshrc
echo "zinit light zsh-users/zsh-autosuggestions" >> ~/.zshrc
echo "zinit snippet OMZP::sudo" >> ~/.zshrc
echo "zinit snippet OMZP::dirhistory" >> ~/.zshrc

zsh
