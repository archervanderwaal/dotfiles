# Dotfiles

My personal configuration files managed by [chezmoi](https://chezmoi.io/).

## What's Included

- **Shell**: zsh + oh-my-zsh + powerlevel10k
- **Editor**: vim + plugins, VSCode
- **Terminal**: tmux + plugins, iTerm2
- **Tools**: git, Claude Code

## Quick Start

```bash
# Install chezmoi
brew install chezmoi

# Clone dotfiles
chezmoi init git@github.com:archervanderwaal/dotfiles.git

# Setup configuration (interactive)
~/.local/share/chezmoi/setup-config.sh

# Apply dotfiles
chezmoi apply

# Run installation script
~/.local/share/chezmoi/install.sh
```

## One-line Setup

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/archervanderwaal/dotfiles/main/install.sh)"
```

## Secrets Management

Sensitive data (API keys, tokens) are managed via `chezmoi.toml`.

### Interactive Setup (Recommended)

```bash
~/.local/share/chezmoi/setup-config.sh
```

This will prompt you for:
- Anthropic API token (for Claude)
- GitHub personal access token (optional)
- OpenAI API key (optional)

### Manual Setup

Create `~/.config/chezmoi/chezmoi.toml`:

```toml
[data.anthropic]
token = "your_anthropic_token"

[data.github]
token = "your_github_token"
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

## Structure

```
~/.local/share/chezmoi/     # Source (git repo)
├── dot_zshrc               # → ~/.zshrc
├── dot_vimrc               # → ~/.vimrc
├── dot_tmux.conf           # → ~/.tmux.conf
├── dot_gitconfig           # → ~/.gitconfig
├── dot_vscode/             # → ~/.vscode/
├── dot_claude/             # → ~/.claude/
├── dot_oh-my-zsh_custom/   # → ~/.oh-my-zsh/custom/
├── setup-config.sh         # Interactive config setup
├── install.sh              # Dependency installer
└── chezmoi.toml.template   # Config template

~/.config/chezmoi/          # Local config (not synced)
└── chezmoi.toml            # Your actual tokens
```

## Installation Script

The `install.sh` script automatically installs:
- Core tools (git, vim, tmux, zsh)
- oh-my-zsh
- vim-plug and vim plugins
- tmux plugins (via TPM)
- VSCode extensions

## New Machine Setup

1. **Install Homebrew** (macOS only):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Clone and setup**:
   ```bash
   brew install chezmoi
   chezmoi init git@github.com:archervanderwaal/dotfiles.git
   ~/.local/share/chezmoi/setup-config.sh
   chezmoi apply
   ~/.local/share/chezmoi/install.sh
   ```

3. **Restart shell**:
   ```bash
   exec zsh
   ```

## Daily Workflow

### After modifying configs:

```bash
# Add changes
dot-add ~/.vimrc

# Push to GitHub
dot-push
```

### On another machine:

```bash
# Pull latest changes
dot-update
```

## Adding New Configs

```bash
# Edit a file
vim ~/.config/myapp/config

# Add to chezmoi
chezmoi add ~/.config/myapp/config

# Commit and push
cd ~/.local/share/chezmoi
git add -A && git commit -m "Add myapp config" && git push
```
