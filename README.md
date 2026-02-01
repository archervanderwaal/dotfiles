# Dotfiles

My personal configuration files managed by [chezmoi](https://chezmoi.io/).

## What's Included

- **Shell**: zsh + oh-my-zsh + powerlevel10k
- **Editor**: vim + plugins
- **Terminal**: tmux + plugins, iTerm2
- **Tools**: git, Claude Code

## Quick Start

```bash
# Install chezmoi
brew install chezmoi

# Apply dotfiles
chezmoi init git@github.com:archervanderwaal/dotfiles.git
chezmoi apply
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
├── dot_claude/            # → ~/.claude/
└── dot_oh-my-zsh_custom/  # → ~/.oh-my-zsh/custom/
```

## New Machine Setup

1. Install oh-my-zsh first:
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

2. Then apply dotfiles:
   ```bash
   chezmoi init git@github.com:archervanderwaal/dotfiles.git && chezmoi apply
   ```
