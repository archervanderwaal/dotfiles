#!/bin/bash
# Installation script for dotfiles dependencies
# Run this script after chezmoi apply to install required software

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Setup configuration file if not exists
CHEZMOI_CONFIG="$HOME/.config/chezmoi/chezmoi.toml"
CHEZMOI_TEMPLATE="$HOME/.local/share/chezmoi/chezmoi.toml.template"

if [[ ! -f "$CHEZMOI_CONFIG" ]]; then
    if [[ -f "$CHEZMOI_TEMPLATE" ]]; then
        print_info "Creating config file from template..."
        mkdir -p "$(dirname "$CHEZMOI_CONFIG")"
        cp "$CHEZMOI_TEMPLATE" "$CHEZMOI_CONFIG"
        print_warn "Please edit $CHEZMOI_CONFIG and fill in your tokens"
        print_warn "Then run: chezmoi apply"
        exit 0
    else
        print_warn "Template not found. Skipping config setup."
    fi
fi

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    INSTALL_CMD="brew install"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    if command -v apt-get &> /dev/null; then
        INSTALL_CMD="sudo apt-get install -y"
    elif command -v yum &> /dev/null; then
        INSTALL_CMD="sudo yum install -y"
    elif command -v pacman &> /dev/null; then
        INSTALL_CMD="sudo pacman -S --noconfirm"
    else
        print_error "Unsupported Linux package manager"
        exit 1
    fi
else
    print_error "Unsupported OS: $OSTYPE"
    exit 1
fi

print_info "Detected OS: $OS"

# Check if Homebrew is installed on macOS
if [[ "$OS" == "macos" ]] && ! command -v brew &> /dev/null; then
    print_warn "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install dependencies
print_info "Installing dependencies..."

# Core tools
if [[ "$OS" == "macos" ]]; then
    brew install chezmoi git vim tmux zsh
else
    $INSTALL_CMD chezmoi git vim tmux zsh
fi

# Install oh-my-zsh if not exists
if [[ ! -d ~/.oh-my-zsh ]]; then
    print_info "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install oh-my-zsh custom plugins
print_info "Installing oh-my-zsh custom plugins..."

# zsh-autosuggestions
if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
    print_info "  Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
else
    print_info "  Updating zsh-autosuggestions..."
    (cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && git pull --quiet)
fi

# zsh-syntax-highlighting
if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
    print_info "  Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
else
    print_info "  Updating zsh-syntax-highlighting..."
    (cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull --quiet)
fi

# powerlevel10k theme
if [[ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]]; then
    print_info "  Installing powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
else
    print_info "  powerlevel10k already installed"
fi

# Install vim-plug if not exists
if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
    print_info "Installing vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install vim plugins
print_info "Installing vim plugins..."
vim +PlugInstall +qall

# Install tmux plugins if TPM exists
if [[ -d ~/.tmux/plugins/tpm ]] && [[ ! -d ~/.tmux/plugins/tmux-sensible ]]; then
    print_info "Installing tmux plugins..."
    ~/.tmux/plugins/tpm/bin/install_plugins
fi

# Install VSCode extensions
if command -v code &> /dev/null; then
    print_info "Installing VSCode extensions..."
    if [[ -f ~/.vscode/extensions/extensions.json ]]; then
        # Read extensions from file and install
        # Note: VSCode extensions format may vary
        code --install-extension eino.eino-dev
        code --install-extension golang.go
    fi
else
    print_warn "VSCode not found. Skipping extension installation."
fi

print_info "Installation complete!"
print_info "Please restart your shell or run: source ~/.zshrc"
