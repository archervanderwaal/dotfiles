# Vim 完整配置总结 🚀

## ✅ 已完成的配置

### 1. 主题和配色
- ✅ GitHub 主题配色（与 iTerm2 一致）
- ✅ 真彩色支持
- ✅ Airline 状态栏 GitHub 主题
- ✅ NERDTree 配色适配

### 2. LSP 和代码导航
- ✅ coc.nvim（支持所有语言）
- ✅ Go 语言服务器
- ✅ 代码补全
- ✅ 跳转到定义 (gd)
- ✅ 查找引用 (gr)
- ✅ 显示文档

### 3. 搜索和导航
- ✅ fzf 模糊文件搜索
- ✅ 全局符号搜索
- ✅ 项目文本搜索
- ✅ 当前文件大纲
- ✅ Tagbar 代码大纲

### 4. 其他插件
- ✅ NERDTree 文件树
- ✅ vim-devicons 文件图标
- ✅ vim-gitgutter Git 状态
- ✅ vim-matchup 改进括号匹配
- ✅ vim-airline 状态栏

### 5. 高级工具
- ✅ 快捷键备忘单
- ✅ 快速启动脚本
- ✅ 高级配置模板

---

## 📂 文件位置

### 配置文件
```
~/.vimrc                    # 主配置文件
~/.vim/colors/github.vim    # GitHub 主题文件
~/.vim/plugged/             # 插件目录
~/.vim/advanced-config.vim  # 高级配置（可选）
~/.vim/cheatsheet.md        # 快捷键备忘单
~/.vim/quick-start.sh       # 快速启动脚本
```

### 参考文档
```
/tmp/vim-navigation-demo.md    # 导航功能演示
/tmp/vim-navigation-guide.txt  # 导航功能速查
/tmp/example-usage.md          # dape-dp 项目实战示例
```

---

## 🎯 核心快捷键速查

### 必记快捷键（最常用）
| 快捷键 | 功能 |
|--------|------|
| `gd` | 跳转到定义 |
| `Ctrl-o` | 返回 |
| `gr` | 查找引用 |
| `K` | 显示文档 |
| `\o` | 文件大纲 |
| `\s` | 符号搜索 |
| `\p` | 快速打开文件 |
| `Ctrl-n` | 文件树 |

### Leader 键快捷键
Leader 键 = `\` (反斜杠)

#### 文件操作
- `\w` - 保存
- `\x` - 保存并退出
- `\q` - 强制退出
- `\ev` - 编辑配置
- `\so` - 重载配置

#### 导航
- `\o` - 当前文件大纲
- `\s` - 全局符号搜索
- `\p` - 快速打开文件
- `\b` - 缓冲区列表
- `\g` - 项目文本搜索

#### 代码
- `gd` - 跳转到定义
- `gr` - 查找引用
- `\rn` - 重命名
- `\f` - 格式化代码
- `K` - 显示文档

#### Git（如果安装了）
- `\gs` - Git 状态
- `\gd` - Git diff
- `\gc` - Git commit

---

## 💪 学习路径

### 第 1 周：基础操作
**目标**: 熟悉基本移动和编辑

每日练习 15 分钟：
- Day 1-2: 基础移动 (hjkl, w, b, e, 0, $)
- Day 3-4: 插入和删除 (i, a, o, dd, dw, x)
- Day 5-6: 复制粘贴 (yy, yw, p, P)
- Day 7: 撤销重做 (u, Ctrl-r)

**练习命令**: `vimtutor`

### 第 2 周：文件操作
**目标**: 掌握文件编辑和保存

- Day 1-2: 保存退出 (:w, :x, :q)
- Day 3-4: 窗口操作 (:sp, :vsp, Ctrl-w)
- Day 5-6: 标签页 (:tabnew, gt, gT)
- Day 7: 查找替换 (/pattern, :%s/old/new/g)

### 第 3 周：进阶功能
**目标**: 使用 LSP 和插件

- Day 1-2: 代码导航 (gd, gr, Ctrl-o)
- Day 3-4: 文件搜索 (\p, \s, \o)
- Day 5-6: NERDTree (Ctrl-n)
- Day 7: 综合练习

### 第 4 周：高级技巧
**目标**: 提高效率

- Day 1-2: 文本对象 (ciw, ci", ci()
- Day 3-4: 宏操作 (qa, @a)
- Day 5-6: 自定义配置
- Day 7: 复习和总结

---

## 📚 常用命令

### Vim 命令
```bash
# 打开文件
vim file.go

# 打开多个文件（每个一个 tab）
vim -p file1.go file2.go

# 恢复上次编辑
vim -r

# 以只读模式打开
vim -R file.go

# 执行 vim 命令
vim +":ls" file.go
```

### 快速启动脚本
```bash
# 项目模式
~/.vim/quick-start.sh -p

# 多文件模式
~/.vim/quick-start.sh -t file1.go file2.go

# 编辑配置
~/.vim/quick-start.sh -c

# Git 模式
~/.vim/quick-start.sh -g
```

### Git 集成
```vim
" 在 vim 中查看 Git 状态
:Git status

" 查看 Git diff
:Git diff

" Git commit
:Git commit

" 查看 Git log
:Git log
```

---

## 🎨 主题切换

### 查看可用主题
```vim
:colorscheme [空格] 然后 Ctrl-d
```

### 临时切换主题
```vim
:colorscheme github
:colorscheme gruvbox
:colorscheme solarized8
```

### 永久切换
编辑 `~/.vimrc`，找到这一行：
```vim
colorscheme github  " 改成你想要的主题
```

---

## 🔧 自定义配置

### 添加自己的快捷键
在 `~/.vimrc` 中添加：
```vim
" 示例：按 F5 运行当前 Go 文件
nnoremap <F5> :w<CR>:!go run %<CR>

" 示例：按 F8 保存并退出
nnoremap <F8> :x<CR>
```

### 修改 Leader 键
在 `~/.vimrc` 中添加：
```vim
let mapleader = ","  " 使用逗号作为 Leader 键
```

### 添加自己的命令
```vim
" 自定义命令
command! Clean %s/\s\+$//g
```

---

## 💡 实用技巧

### 1. 批量缩进
```
v 进入可视模式 → 选择多行 → > 增加缩进 / < 减少缩进
```

### 2. 快速选择括号内容
```
ci( - 修改括号内容
ca" - 修改引号及内容
```

### 3. 重复上一次操作
```
. - 重复最后一次普通模式操作
```

### 4. 大小写转换
```
~ - 切换字符大小写
gUw - 单词转大写
guw - 单词转小写
```

### 5. 宏录制
```
qa - 开始录制到寄存器 a
执行操作...
q - 停止录制
@a - 执行宏 a
```

---

## 🆘 故障排查

### 问题 1: 插件不工作
```vim
" 检查插件状态
:PlugStatus

" 重新安装插件
:PlugInstall

" 更新插件
:PlugUpdate
```

### 问题 2: coc.nvim 不工作
```vim
" 检查 coc 状态
:CocInfo

" 重启 coc
:CocRestart

" 查看日志
:CocOpenLog
```

### 问题 3: 快捷键冲突
```vim
" 查看所有快捷键映射
:map

" 查看特定快捷键
:map <leader>p
```

### 问题 4: 主题不生效
```vim
" 检查主题文件
:echo globpath(&rtp, "colors/github.vim")

" 手动加载
:colorscheme github
```

---

## 📖 学习资源

### 官方文档
- `:help` - 帮助文档
- `:help user-manual` - 用户手册
- `vimtutor` - 交互式教程（在终端运行）

### 在线资源
- https://vim.rtorr.com/ - 中文 Vim 文档
- https://github.com/mbadolato/iTerm2-Color-Schemes - iTerm2 配色
- https://github.com/neoclide/coc.nvim - coc.nvim 文档

### 社区
- r/vim - Reddit Vim 社区
- Stack Overflow - Vim 标签

---

## 🎊 总结

你现在拥有一个功能完整的 Vim 开发环境：

✅ **美观** - GitHub 主题配色
✅ **智能** - LSP 代码补全和导航
✅ **高效** - 模糊搜索和快速跳转
✅ **强大** - 丰富的插件和配置
✅ **可扩展** - 易于自定义

### 下一步行动：

1. **立即开始使用**
   ```bash
   vim internal/model/grab/grab.go
   ```

2. **熟悉快捷键**
   ```vim
   :e ~/.vim/cheatsheet.md
   ```

3. **每天练习 15 分钟**
   - 使用 vim 完成日常编辑
   - 尝试新的快捷键
   - 逐渐减少对鼠标的依赖

4. **自定义配置**
   - 根据自己的习惯调整
   - 添加更多实用功能
   - 打造最适合自己的开发环境

---

**Happy Vimming! 🚀**
