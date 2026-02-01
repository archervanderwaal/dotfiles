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

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
else
    print_error "Unsupported OS: $OSTYPE"
    exit 1
fi

print_info "Detected OS: $OS"

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

################################################################################
# Step 1: Install Homebrew
################################################################################

if [[ "$OS" == "macos" ]]; then
    if ! command -v brew &> /dev/null; then
        print_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add Homebrew to PATH for current session
        if [[ -f "/opt/homebrew/bin/brew" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -f "/usr/local/bin/brew" ]]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    else
        print_info "Homebrew already installed"
    fi

   ################################################################################
    # Step 2: Configure Homebrew git remote (Tsinghua mirror)
    ################################################################################

    print_info "Configuring Homebrew git remote..."
    cd "$(brew --repo)" && git remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git

    ################################################################################
    # Step 3: Install all packages from Brewfile
    ################################################################################

    if [[ -f ~/.Brewfile ]]; then
        print_info "Installing packages from Brewfile..."
        if ! brew bundle --file=~/.Brewfile; then
            print_warn "Some packages failed to install. Check output above."
            print_warn "Continuing with remaining steps..."
        fi
    else
        print_warn "Brewfile not found, skipping..."
    fi

   ################################################################################
    # Step 4: Install oh-my-zsh
    ################################################################################

    if [[ ! -d ~/.oh-my-zsh ]]; then
        print_info "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    ################################################################################
    # Step 5: Install oh-my-zsh custom plugins
    ################################################################################

    print_info "Installing oh-my-zsh custom plugins..."

    # zsh-autosuggestions
    if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
        print_info "  Installing zsh-autosuggestions..."
        if ! git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions; then
            print_warn "  Failed to install zsh-autosuggestions"
        fi
    else
        print_info "  Updating zsh-autosuggestions..."
        (cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && git pull --quiet) || print_warn "  Failed to update zsh-autosuggestions"
    fi

    # zsh-syntax-highlighting
    if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
        print_info "  Installing zsh-syntax-highlighting..."
        if ! git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting; then
            print_warn "  Failed to install zsh-syntax-highlighting"
        fi
    else
        print_info "  Updating zsh-syntax-highlighting..."
        (cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull --quiet) || print_warn "  Failed to update zsh-syntax-highlighting"
    fi

    # powerlevel10k theme
    if [[ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]]; then
        print_info "  Installing powerlevel10k..."
        if ! git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k; then
            print_warn "  Failed to install powerlevel10k"
        fi
    else
        print_info "  powerlevel10k already installed"
    fi

   ################################################################################
    # Step 6: Install vim plugins (if vim is used)
    ################################################################################

    if command -v vim &> /dev/null; then
        print_info "Installing vim plugins..."
        if ! vim +PlugInstall +qall; then
            print_warn "Failed to install vim plugins"
        fi
    fi

   ################################################################################
    # Step 7: Install tmux plugins (if tmux is used)
    ################################################################################

    if [[ -d ~/.tmux/plugins/tpm ]] && [[ ! -d ~/.tmux/plugins/tmux-sensible ]]; then
        print_info "Installing tmux plugins..."
        if ! ~/.tmux/plugins/tpm/bin/install_plugins; then
            print_warn "Failed to install tmux plugins"
        fi
    fi

elif [[ "$OS" == "linux" ]]; then
    ################################################################################
    # Linux: Use system package manager
    ################################################################################

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

    print_info "Installing packages with system package manager..."
    $INSTALL_CMD git vim tmux zsh

    # Install oh-my-zsh
    if [[ ! -d ~/.oh-my-zsh ]]; then
        print_info "Installing oh-my-zsh..."
        if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; then
            print_warn "Failed to install oh-my-zsh"
        fi
    fi

    # Install zsh plugins (same as macOS)
    print_info "Installing oh-my-zsh custom plugins..."

    if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
        if ! git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions; then
            print_warn "Failed to install zsh-autosuggestions"
        fi
    fi

    if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
        if ! git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting; then
            print_warn "Failed to install zsh-syntax-highlighting"
        fi
    fi
fi

################################################################################
# Complete
################################################################################

echo ""
print_info "Installation complete!"
echo ""
echo "Please restart your shell or run: exec zsh"
