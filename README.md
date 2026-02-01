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

# Apply dotfiles (will prompt for config if needed)
chezmoi apply

# Install dependencies (auto-creates config if needed)
~/.local/share/chezmoi/install.sh

# Edit your tokens
vim ~/.config/chezmoi/chezmoi.toml

# Re-apply with your tokens
chezmoi apply

# Restart shell
exec zsh
```

## Secrets Management

The `install.sh` script automatically creates `~/.config/chezmoi/chezmoi.toml` from template.

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
# 1. Install Homebrew (macOS)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Install chezmoi and clone dotfiles
brew install chezmoi
chezmoi init git@github.com:archervanderwaal/dotfiles.git

# 3. Apply configs
chezmoi apply

# 4. Run installer (auto-creates config template)
~/.local/share/chezmoi/install.sh

# 5. Edit config and fill your tokens
vim ~/.config/chezmoi/chezmoi.toml

# 6. Re-apply
chezmoi apply

# 7. Restart shell
exec zsh
```

### Or One-line

```bash
brew install chezmoi && \
chezmoi init git@github.com:archervanderwaal/dotfiles.git && \
chezmoi apply && \
~/.local/share/chezmoi/install.sh
# Then edit ~/.config/chezmoi/chezmoi.toml and run: chezmoi apply && exec zsh
```

## Daily Workflow

### After modifying configs:

```bash
dot-add ~/.vimrc
dot-push
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
