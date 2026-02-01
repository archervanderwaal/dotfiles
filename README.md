# Dotfiles

使用 [chezmoi](https://chezmoi.io/) 管理的个人配置文件。

## 支持的应用

- tmux + 插件
- vim + 插件
- git
- zsh
- iTerm2

## 快速开始

### 1. 安装 chezmoi

**macOS:**
```bash
brew install chezmoi
```

**Linux:**
```bash
curl -fsSL https://chezmoi.io/get | sh
```

### 2. 拉取配置

```bash
chezmoi init https://github.com/mayongbin/dotfiles
chezmoi apply
```

## 敏感信息处理

配置文件中的 API key 等敏感信息使用 chezmoi 模板功能处理。

### 设置环境变量

在 `~/.config/chezmoi/chezmoi.toml` 中添加：

```toml
[data.github]
token = "your_github_token"

[data.openai]
apikey = "your_openai_api_key"
```

或者在 shell 配置中设置（不推荐，仅在临时使用）：

```bash
export GITHUB_TOKEN="your_token"
export OPENAI_API_KEY="your_key"
```

### 添加新的敏感信息

1. 在 `.chezmoi.yaml.tmpl` 中定义变量
2. 在配置文件中使用 `{{ .variable_name }}` 引用
3. 将文件重命名为 `*.tmpl`
4. 重新添加到 chezmoi：`chezmoi add ~/.config/yourfile`

## 常用命令

```bash
# 查看状态
chezmoi status

# 添加新文件
chezmoi add ~/.config/yourfile

# 编辑源文件
chezmoi edit ~/.config/yourfile

# 应用配置
chezmoi apply

# 查看差异
chezmoi diff
```

## 结构说明

```
~/.local/share/chezmoi/
├── .chezmoi.yaml.tmpl    # chezmoi 配置模板
├── .chezmoiignore         # 排除文件列表
├── dot_gitconfig         # -> ~/.gitconfig
├── dot_vimrc             # -> ~/.vimrc
├── dot_tmux.conf         # -> ~/.tmux.conf
└── private_config/       # 敏感信息模板
    └── private.tmpl      # -> ~/.config/private/private
```

## 注意事项

- **不要**将真实的 API key 提交到仓库
- 使用 `.chezmoiignore` 排除敏感文件
- 定期审查提交历史，确保无泄露
