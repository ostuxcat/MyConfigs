# ZSH CORE
autoload -Uz colors && colors;
autoload -Uz promptinit && promptinit;

#ZSH HISTORY
HISTFILE="$HOME/.zsh-history";
HISTSIZE=5000;
SAVEHIST=5000;
setopt SHARE_HISTORY;
unsetopt nomatch;

# MY SHITTY CONFIG
if [[ -f "/etc/os-release" ]]; then
    DISTRO=$(grep -m1 "^ID=*" "/etc/os-release" | cut -d= -f2 | tr -d '"');
else
    DISTRO="null";
fi
if [[ "$DISTRO" == "debian" ]]; then
    alias upd="sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y";
    alias fwd="sudo fwupdmgr upgrade -y";
elif [[ "$DISTRO" == "fedora" ]]; then
    alias upd="sudo dnf upgrade -y && sudo dnf autoremove -y";
    alias fwd="sudo fwupdmgr upgrade -y";
elif [[ "$DISTRO" == "arch" ]]; then
    if [[ -z "$(pacman -Qdtq 2>/dev/null | tr -d '\n')" ]]; then
        alias upd="sudo pacman -Syu";
    else
        alias upd="sudo pacman -Syu && sudo pacman -Rns $(pacman -Qdtq)";
    fi
else
  alias upd='echo "Unknown distro: $DISTRO"';
fi
if [[ "$ZED_TERM" == "true" ]]; then
    export ZED_DIR="$PWD";
fi
cd() {
  if [[ $# -eq 0 ]] && [[ -n "$ZED_DIR" ]]; then
    builtin cd "$ZED_DIR";
  else
    builtin cd "$@";
  fi
}
export PATH="$HOME/.local/bin:$PATH";
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env";

# bun completions
[[ -s "/home/ostuxcat/.bun/_bun" ]] && source "/home/ostuxcat/.bun/_bun";

# bun
export BUN_INSTALL="$HOME/.bun";
export PATH="$BUN_INSTALL/bin:$PATH";

# THEME
[[ -f "$HOME/.zsh/ostuxcat.zsh-theme" ]] && source "$HOME/.zsh/ostuxcat.zsh-theme";

# completions
autoload -Uz compinit && compinit;

# ZSH PLUGINS
source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh";
source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
