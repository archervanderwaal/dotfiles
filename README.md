# Dotfiles

My personal configuration files managed by [chezmoi](https://chezmoi.io/).

## What's Included

- **Shell**: zsh + oh-my-zsh + powerlevel10k
- **Editor**: vim + plugins, VSCode
- **Terminal**: tmux + plugins, iTerm2
- **Tools**: git, Claude Code, Homebrew packages

## Quick Start

```bash
# Install Homebrew (macOS)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install chezmoi
brew install chezmoi

# Clone dotfiles
chezmoi init git@github.com:archervanderwaal/dotfiles.git

# Setup configuration
cp ~/.local/share/chezmoi/chezmoi.toml.template ~/.config/chezmoi/chezmoi.toml
# Edit ~/.config/chezmoi/chezmoi.toml and fill in your tokens

# Apply dotfiles
chezmoi apply

# Run installation script (installs Homebrew packages, plugins, etc.)
~/.local/share/chezmoi/install.sh

# Restart shell
exec zsh
```

## Homebrew Management

All Homebrew packages are managed via `Brewfile`.

### List installed packages

```bash
brew bundle list --file=~/.Brewfile
```

### Add new package

```bash
# Install package
brew install package-name

# Update Brewfile
brew bundle dump --file=~/.Brewfile --force

# Commit to dotfiles
cd ~/.local/share/chezmoi
git add Brewfile
git commit -m "Add package-name"
git push
```

### Install all packages on new machine

```bash
brew bundle --file=~/.Brewfile
```

## Secrets Management

Sensitive data (API keys, tokens) are managed via `chezmoi.toml`.

Fill in your tokens:

```toml
[data.anthropic]
token = "sk-ant-xxx..."

# Delete sections you don't need
[data.github]
token = ""

[data.openai]
apikey = ""
```

## Common Commands

```bash
dot                    # Enter dotfiles directory
dot-add ~/.file        # Add file to chezmoi
dot-status             # View changes
dot-apply              # Apply all configs
dot-update             # Pull and apply remote changes
dot-push               # Commit and push changes
```

## New Machine Setup

### Complete Setup

```bash
# 1. Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Install chezmoi and clone dotfiles
brew install chezmoi
chezmoi init git@github.com:archervanderwaal/dotfiles.git

# 3. Setup configuration
cp ~/.local/share/chezmoi/chezmoi.toml.template ~/.config/chezmoi/chezmoi.toml
vim ~/.config/chezmoi/chezmoi.toml  # Fill in your tokens

# 4. Apply configs
chezmoi apply

# 5. Run installer (installs Homebrew packages, plugins, etc.)
~/.local/share/chezmoi/install.sh

# 6. Restart shell
exec zsh
```

## Daily Workflow

### After modifying configs:

```bash
dot-add ~/.vimrc
dot-push
```

### After installing new Homebrew package:

```bash
# Update Brewfile
brew bundle dump --file=~/.Brewfile --force

# Commit
cd ~/.local/share/chezmoi
git add Brewfile
git commit -m "Add new package"
git push
```

### On another machine:

```bash
dot-update
```

## Adding New Configs

```bash
vim ~/.config/myapp/config
chezmoi add ~/.config/myapp/config
cd ~/.local/share/chezmoi
git commit -m "Add myapp config" && git push
```

## Installation Script

The `install.sh` script automatically installs:
- Core tools (git, vim, tmux, zsh)
- Homebrew packages from Brewfile
- oh-my-zsh
- vim-plug and vim plugins
- Node.js (for coc.nvim)
- tmux plugins (via TPM)
- zsh plugins (zsh-autosuggestions, zsh-syntax-highlighting)
- powerlevel10k theme
- iTerm2 configuration
