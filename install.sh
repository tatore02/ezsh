#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

SUDO_USER_HOME=$(eval echo ~"$SUDO_USER")

if [[ -z "$SUDO_USER_HOME" || "$SUDO_USER_HOME" == "/root" ]]; then
    echo "Unable to detect user home directory. Exiting..."
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
    chsh -s "$(which zsh)" "$SUDO_USER"
fi

echo "Installing Oh-my-ZSH..."
sudo -u "$SUDO_USER" sh -c 'echo "y" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'

echo "Installing nerd-fonts..."
sudo -u "$SUDO_USER" mkdir -p "$SUDO_USER_HOME/.fonts"
sudo -u "$SUDO_USER" curl --remote-name-all https://github.com/romkatv/powerlevel10k-media/raw/master/{MesloLGS%20NF%20Regular.ttf,MesloLGS%20NF%20Bold.ttf,MesloLGS%20NF%20Italic.ttf,MesloLGS%20NF%20Bold%20Italic.ttf}
sudo -u "$SUDO_USER" mv -n MesloLGS%20NF%20Regular.ttf MesloLGS%20NF%20Bold.ttf MesloLGS%20NF%20Italic.ttf MesloLGS%20NF%20Bold%20Italic.ttf "$SUDO_USER_HOME/.fonts"
sudo -u "$SUDO_USER" fc-cache -fv &> /dev/null

echo "Installing Powerlevel10k..."
sudo -u "$SUDO_USER" git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$SUDO_USER_HOME/powerlevel10k"
sudo -u "$SUDO_USER" sh -c 'echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >> "$HOME/.zshrc"'

echo "Installing Zinit..."
sudo -u "$SUDO_USER" sh -c 'echo "y" | bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"'

echo "Adding plugins to ZSHRC..."
sudo -u "$SUDO_USER" sh -c 'echo "zinit light zdharma-continuum/fast-syntax-highlighting" >> "$HOME/.zshrc"'
sudo -u "$SUDO_USER" sh -c 'echo "zinit light zsh-users/zsh-autosuggestions" >> "$HOME/.zshrc"'
sudo -u "$SUDO_USER" sh -c 'echo "zinit snippet OMZP::sudo" >> "$HOME/.zshrc"'
sudo -u "$SUDO_USER" sh -c 'echo "zinit snippet OMZP::dirhistory" >> "$HOME/.zshrc"'

sudo -u "$SUDO_USER" zsh
