detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$NAME"
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        echo "$DISTRIB_ID"
    elif [ -f /etc/debian_version ]; then
        echo "Debian"
    elif [ -f /etc/redhat-release ]; then
        echo "$(cat /etc/redhat-release)"
    else
        echo "Distro not detected"
    fi
}