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

# Apply dotfiles
chezmoi init git@github.com:archervanderwaal/dotfiles.git
chezmoi apply

# Run installation script
~/.local/share/chezmoi/install.sh
```

## One-line Setup

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/archervanderwaal/dotfiles/main/install.sh)"
```

## Secrets Management

Sensitive data (API keys, tokens) are handled via chezmoi templates.

Create `~/.config/chezmoi/chezmoi.toml`:

```toml
[data.anthropic]
token = "your_anthropic_token"

[data.github]
token = "your_github_token"
```

## Common Commands

```bash
chezmoi status      # View changes
chezmoi add ~/.file # Add new file
chezmoi edit ~/.file # Edit source file
chezmoi apply       # Apply all configs
```

## Structure

```
~/.local/share/chezmoi/
├── dot_zshrc              # → ~/.zshrc
├── dot_vimrc              # → ~/.vimrc
├── dot_tmux.conf          # → ~/.tmux.conf
├── dot_gitconfig          # → ~/.gitconfig
├── dot_vscode/            # → ~/.vscode/
├── dot_claude/            # → ~/.claude/
└── dot_oh-my-zsh_custom/  # → ~/.oh-my-zsh/custom/
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

2. **Clone and apply**:
   ```bash
   brew install chezmoi
   chezmoi init git@github.com:archervanderwaal/dotfiles.git
   chezmoi apply
   ~/.local/share/chezmoi/install.sh
   ```

3. **Set secrets**:
   ```bash
   mkdir -p ~/.config/chezmoi
   # Edit ~/.config/chezmoi/chezmoi.toml with your tokens
   ```

4. **Restart shell**:
   ```bash
   exec zsh
   ```
