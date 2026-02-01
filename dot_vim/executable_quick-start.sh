#!/bin/bash
# ============================================================================
# Vim 快速启动脚本 - 带有常用功能和快捷操作
# ============================================================================

show_help() {
    cat << 'HELP'
╔═════════════════════════════════════════════════════════════════════╗
║                     Vim 快速启动工具 v1.0                             ║
╚═════════════════════════════════════════════════════════════════════╝

用法: vim-quick [选项] [文件/目录]

选项:
  -p, --project     在项目根目录启动 vim
  -t, --tab         打开多个文件（每个文件一个 tab）
  -s, --session     恢复上次会话
  -c, --config      编辑 vim 配置文件
  -h, --help        显示帮助信息
  -d, --debug       启动调试模式
  -g, --git         打开 git status
  -r, --recent      显示最近打开的文件
  --no-plugin       不加载插件（快速启动）
  --minimal         最小化模式（无配置）

示例:
  vim-quick file.go              # 打开文件
  vim-quick -p                   # 在项目根目录启动
  vim-quick -t file1.go file2.go # 多文件模式
  vim-quick -c                   # 编辑配置
  vim-quick -d internal/         # 调试模式打开目录

快捷键提示:
  在 vim 中按 <leader>h 查看所有快捷键

HELP
}

# 默认值
PROJECT_MODE=false
TAB_MODE=false
SESSION_MODE=false
CONFIG_MODE=false
DEBUG_MODE=false
GIT_MODE=false
RECENT_MODE=false
NO_PLUGIN=false
MINIMAL_MODE=false

# 解析参数
while [[ $# -gt 0 ]]; do
    case $1 in
        -p|--project)
            PROJECT_MODE=true
            shift
            ;;
        -t|--tab)
            TAB_MODE=true
            shift
            ;;
        -s|--session)
            SESSION_MODE=true
            shift
            ;;
        -c|--config)
            CONFIG_MODE=true
            shift
            ;;
        -d|--debug)
            DEBUG_MODE=true
            shift
            ;;
        -g|--git)
            GIT_MODE=true
            shift
            ;;
        -r|--recent)
            RECENT_MODE=true
            shift
            ;;
        --no-plugin)
            NO_PLUGIN=true
            shift
            ;;
        --minimal)
            MINIMAL_MODE=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            FILES+=("$1")
            shift
            ;;
    esac
done

# 查找项目根目录
find_project_root() {
    local dir=$(pwd)
    while [ "$dir" != "/" ]; do
        if [ -f "$dir/go.mod" ] || \
           [ -f "$dir/package.json" ] || \
           [ -f "$dir/.git/config" ] || \
           [ -d "$dir/.git" ] || \
           [ -f "$dir/Makefile" ] || \
           [ -f "$dir/Cargo.toml" ]; then
            echo "$dir"
            return 0
        fi
        dir=$(dirname "$dir")
    done
    echo "$(pwd)"
}

# 构建 vim 命令
build_vim_cmd() {
    local cmd="vim"

    if [ "$NO_PLUGIN" = true ]; then
        cmd="$cmd --noplugin"
    fi

    if [ "$MINIMAL_MODE" = true ]; then
        cmd="$cmd -u NONE"
    fi

    if [ "$DEBUG_MODE" = true ]; then
        cmd="$cmd -V1"
    fi

    echo "$cmd"
}

# 主逻辑
main() {
    local vim_cmd=$(build_vim_cmd)

    # 配置模式
    if [ "$CONFIG_MODE" = true ]; then
        echo "📝 打开 vim 配置..."
        exec $vim_cmd ~/.vimrc
    fi

    # 项目模式
    if [ "$PROJECT_MODE" = true ]; then
        local root=$(find_project_root)
        echo "📂 项目根目录: $root"
        cd "$root"
        if [ ${#FILES[@]} -eq 0 ]; then
            exec $vim_cmd
        else
            exec $vim_cmd "${FILES[@]}"
        fi
    fi

    # Git 模式
    if [ "$GIT_MODE" = true ]; then
        echo "🌲 Git 状态..."
        cd "$(find_project_root)"
        if [ -d ".git" ]; then
            exec $vim_cmd +:GStatus
        else
            echo "❌ 不是 Git 仓库"
            exit 1
        fi
    fi

    # 最近文件模式
    if [ "$RECENT_MODE" = true ]; then
        echo "🕒 最近打开的文件..."
        exec $vim_cmd +:History
    fi

    # Tab 模式
    if [ "$TAB_MODE" = true ] && [ ${#FILES[@]} -gt 0 ]; then
        echo "📑 打开 ${#FILES[@]} 个文件..."
        local args=""
        for file in "${FILES[@]}"; do
            args="$args -p \"$file\""
        done
        eval "exec $vim_cmd $args"
    fi

    # 默认模式
    if [ ${#FILES[@]} -eq 0 ]; then
        # 没有文件，显示帮助
        exec $vim_cmd
    else
        exec $vim_cmd "${FILES[@]}"
    fi
}

main
