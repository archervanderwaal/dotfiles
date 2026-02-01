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

# Setup configuration
cp ~/.local/share/chezmoi/chezmoi.toml.template ~/.config/chezmoi/chezmoi.toml
# Edit ~/.config/chezmoi/chezmoi.toml and fill in your tokens

# Apply dotfiles
chezmoi apply

# Run installation script
~/.local/share/chezmoi/install.sh
```

## Secrets Management

Sensitive data (API keys, tokens) are managed via `chezmoi.toml`.

### Setup Configuration

1. Copy the template:
```bash
cp ~/.local/share/chezmoi/chezmoi.toml.template ~/.config/chezmoi/chezmoi.toml
```

2. Edit and fill your tokens:
```bash
vim ~/.config/chezmoi/chezmoi.toml
```

3. Fill in your actual tokens:
```toml
[data.anthropic]
token = "sk-ant-xxx..."

[data.github]
token = "ghp_xxx..."

[data.openai]
apikey = "sk-xxx..."
```

Delete the sections you don't need.

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
├── install.sh              # Dependency installer
└── chezmoi.toml.template   # Config template

~/.config/chezmoi/          # Local config (not synced)
└── chezmoi.toml            # Your actual tokens
```

## New Machine Setup

1. **Install Homebrew** (macOS):
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Clone dotfiles**:
   ```bash
   brew install chezmoi
   chezmoi init git@github.com:archervanderwaal/dotfiles.git
   ```

3. **Setup configuration**:
   ```bash
   cp ~/.local/share/chezmoi/chezmoi.toml.template ~/.config/chezmoi/chezmoi.toml
   vim ~/.config/chezmoi/chezmoi.toml  # Fill in your tokens
   ```

4. **Apply and install**:
   ```bash
   chezmoi apply
   ~/.local/share/chezmoi/install.sh
   ```

5. **Restart shell**:
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
git commit -m "Add myapp config" && git push
```

## Installation Script

The `install.sh` script automatically installs:
- Core tools (git, vim, tmux, zsh)
- oh-my-zsh
- vim-plug and vim plugins
- tmux plugins (via TPM)
- VSCode extensions
