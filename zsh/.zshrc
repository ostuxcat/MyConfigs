export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="ostuxcat"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

# MY SHITTY CONFIG
if [[ -f /etc/os-release ]]; then
    DISTRO=$(grep -m1 "^ID=*" /etc/os-release | cut -d= -f2 | tr -d '"')
else
    DISTRO="null"
fi
if [[ "$DISTRO" == "debian" ]]; then
    alias upd="sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y"
    alias fwd="sudo fwupdmgr upgrade -y"
elif [[ "$DISTRO" == "fedora" ]]; then
    alias upd="sudo dnf upgrade -y && sudo dnf autoremove -y"
    alias fwd="sudo fwupdmgr upgrade -y"
elif [[ "$DISTRO" == "arch" ]]; then
    if [[ -z "$(pacman -Qdtq 2>/dev/null | tr -d '\n')" ]]; then
        alias upd="sudo pacman -Syu"
    else
        alias upd="sudo pacman -Syu && sudo pacman -Rns $(pacman -Qdtq)"
    fi
else
  alias upd='echo "Unknown distro: $DISTRO"'
fi
if [[ "$ZED_TERM" == "true" ]]; then
    export ZED_DIR="$PWD"
fi
cd() {
  if [[ $# -eq 0 ]] && [[ -n "$ZED_DIR" ]]; then
    builtin cd "$ZED_DIR"
  else
    builtin cd "$@"
  fi
}
source $ZSH/oh-my-zsh.sh
unsetopt nomatch
export PATH=$HOME/.local/bin:$PATH
source "$HOME/.cargo/env"
