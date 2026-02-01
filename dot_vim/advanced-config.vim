" ============================================================================
" Vim 高级配置和实用技巧
" ============================================================================
" 这个文件包含了进阶配置，可以整合到 ~/.vimrc 中

" ============================================================================
" 1. 性能优化
" ============================================================================

" 加快 vim 启动速度
set lazyredraw          " 宏执行时不重绘
set ttyfast             " 加快终端渲染
set updatetime=300      " 更快的交换文件写入

" 禁用不必要的功能
set noswapfile          " 不使用交换文件
set nobackup            " 不创建备份文件
set nowritebackup       " 不创建备份文件
set shortmess+=c        " 减少 completion 消息

" ============================================================================
" 2. 编辑增强
" ============================================================================

" 自动保存和恢复光标位置
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" 自动切换到文件目录
autocmd BufEnter * lcd %:p:h

" 窗口大小调整
noremap <silent> <C-Up> :resize +2<CR>
noremap <silent> <C-Down> :resize -2<CR>
noremap <silent> <C-Left> :vertical resize -2<CR>
noremap <silent> <C-Right> :vertical resize +2<CR>

" 快速移动到行首行尾（在普通模式下）
noremap H ^
noremap L $

" 快速选中整个文件
nnoremap <leader>a ggVG

" 快速复制到系统剪贴板
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y
nnoremap <leader>yy "+yy

" 从系统剪贴板粘贴
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P

" ============================================================================
" 3. 搜索和替换增强
" ============================================================================

" 实时高亮搜索结果
set incsearch
set hlsearch

" 清除搜索高亮
nnoremap <silent> <leader>/ :nohlsearch<CR>

" 搜索当前单词
nnoremap <leader>fw :%s/\<<C-r><C-w>\>//g<Left><Left>

" 全局替换确认
nnoremap <leader>ra :%s///gc<Left><Left><Left>

" ============================================================================
" 4. Tab 和窗口管理
" ============================================================================

" 更好的 tab 切换
nnoremap th :tabfirst<CR>
nnoremap tj :tabnext<CR>
nnoremap tk :tabprev<CR>
nnoremap tl :tablast<CR>
nnoremap td :tabclose<CR>
nnoremap tn :tabnew<CR>

" 新 tab 并切换
nnoremap <leader>te :tabedit<Space>

" 移动 tab
nnoremap <leader>tm :tabmove<Space>

" 窗口分割
nnoremap <leader>sv :split<CR>
nnoremap <leader>sh :vsplit<CR>

" 窗口导航（更直观）
nnoremap <leader>w <C-w>w
nnoremap <leader>W <C-w>W

" ============================================================================
" 5. 快速编辑和保存
" ============================================================================

" 快速保存
nnoremap <leader>w :w<CR>
" 快速保存并退出
nnoremap <leader>x :x<CR>
" 快速强制退出
nnoremap <leader>q :q!<CR>

" 重新加载配置
nnoremap <leader>so :source ~/.vimrc<CR>

" 编辑配置文件
nnoremap <leader>ev :e ~/.vimrc<CR>

" ============================================================================
" 6. 代码折叠
" ============================================================================

" 启用折叠
set foldmethod=indent
set foldlevel=99
set foldlevelstart=99

" 折叠快捷键
nnoremap <space> za
nnoremap <leader>z0 zM
nnoremap <leader>z1 zR
nnoremap <leader>za zA
nnoremap <leader>zm zM
nnoremap <leader>zr zR

" ============================================================================
" 7. 命令行模式增强
" ============================================================================

" 命令历史
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

" 快速访问命令行
nnoremap ; :

" ============================================================================
" 8. 实用宏和文本对象
" ============================================================================

" 快速添加/删除行注释（需要插件支持）
nnoremap <leader>c gcc

" 选中当前行
nnoremap <leader>v V

" 选中块
nnoremap <leader>b <C-v>

" ============================================================================
" 9. Git 集成（如果有 vim-fugitive）
" ============================================================================

" Git 状态
nnoremap <leader>gs :Git<CR>

" Git diff
nnoremap <leader>gd :Gdiff<CR>

" Git commit
nnoremap <leader>gc :Git commit<CR>

" ============================================================================
" 10. 实用函数
" ============================================================================

" 删除所有尾随空格
function! StripTrailingWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

" 手动删除空格
command! StripTrailingWhitespace call StripTrailingWhitespace()
nnoremap <leader>sw :StripTrailingWhitespace<CR>

" 保存时自动删除空格（可选）
" autocmd BufWritePre * :call StripTrailingWhitespace()

" ============================================================================
" 11. 项目管理
" ============================================================================

" 快速切换到项目根目录
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" 打开项目文件列表
nnoremap <leader>pf :Files<CR>

" 在项目中搜索文本
nnoremap <leader>pg :Rg<CR>

" ============================================================================
" 12. 终端集成
" ============================================================================

" 在 vim 中打开终端
nnoremap <leader>tt :terminal<CR>

" 在下方打开终端
nnoremap <leader>ts :split \| terminal<CR>

" 在右侧打开终端
nnoremap <leader>tv :vsplit \| terminal<CR>

" 退出终端模式
tnoremap <Esc> <C-\><C-n>

" ============================================================================
" 13. 编程辅助
" ============================================================================

" 快速运行当前文件
autocmd FileType go nnoremap <buffer> <leader>r :w<CR>:GoRun<CR>
autocmd FileType python nnoremap <buffer> <leader>r :w<CR>:!python3 %<CR>
autocmd FileType sh nnoremap <buffer> <leader>r :w<CR>:!bash %<CR>

" 快速运行测试
autocmd FileType go nnoremap <buffer> <leader>t :w<CR>:GoTest -s<CR>
autocmd FileType python nnoremap <buffer> <leader>t :w<CR>:!python3 -m pytest %<CR>

" 快速切换头文件和源文件
nnoremap <leader>aa :A<CR>

" ============================================================================
" 14. 拼写检查
" ============================================================================

" 启用拼写检查
function! ToggleSpell()
    if &spell == 0
        setlocal spell spelllang=en_us
        echo "Spell check ON (en_US)"
    else
        setlocal nospell
        echo "Spell check OFF"
    endif
endfunction

nnoremap <leader>sp :call ToggleSpell()<CR>

" 下一个/上一个拼写错误
nnoremap <leader>sn ]s
nnoremap <leader>sp [s

" 添加到拼写字典
nnoremap <leader>sa zg

" ============================================================================
" 15. 标记和跳转
" ============================================================================

" 快速设置标记
nnoremap <leader>mm mm

" 快速跳转到标记 m
nnoremap <leader>gm 'm

" 显示所有标记
nnoremap <leader>ml :marks<CR>

" ============================================================================
" 16. 实用状态栏信息
" ============================================================================

" 显示文件编码
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}

" 显示文件格式
set statusline+=\ [%{&fileformat}]

" 显示光标位置
set statusline+=\ %l:%c

" ============================================================================
" 17. 自动命令
" ============================================================================

" 自动创建目录（如果不存在）
autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")

" Focus 失去时自动保存
" autocmd FocusLost * :wa

" 自动重新读取文件（如果在外部被修改）
set autoread
autocmd FocusGained,BufEnter * :checktime

" ============================================================================
" 18. 鼠标支持
" ============================================================================

" 启用鼠标
set mouse=a

" 右键粘贴
noremap! <RightMouse> <Paste>

" ============================================================================
" 19. 可视化缩进指示线
" ============================================================================

" 如果有 indentLine 插件
" let g:indentLine_char = '│'
" let g:indentLine_color_term = 239
" let g:indentLine_color_gui = '#4B5263'
" let g:indentLine_enabled = 1

" ============================================================================
" 20. 平滑滚动
" ============================================================================

" 如果有 vim-smooth-scroll 插件
" noremap <silent> <C-e> :SmoothScrollUp<CR>
" noremap <silent> <C-y> :SmoothScrollDown<CR>

" ============================================================================
" 快捷键速查表
" ============================================================================

" <leader> 键映射总结:
"   a   - 全选
"   b   - 可视块
"   c   - 注释/取消注释
"   cd  - 切换到文件目录
"   cd  - 切换到项目根目录
"   ev  - 编辑 vimrc
"   fw  - 查找并替换当前单词
"   g   - Git 相关
"   p   - 粘贴
"   pf  - 项目文件列表
"   pg  - 项目文本搜索
"   q   - 强制退出
"   r   - 运行当前文件
"   ra  - 全局替换
"   so  - 重新加载配置
"   sp  - 切换拼写检查
"   sv  - 水平分割窗口
"   sh  - 垂直分割窗口
"   sw  - 删除尾随空格
"   t   - Tab 相关
"   te  - 新 tab
"   td  - 关闭 tab
"   th  - 第一个 tab
"   tj  - 下一个 tab
"   tk  - 上一个 tab
"   tl  - 最后一个 tab
"   tn  - 新 tab
"   tm  - 移动 tab
"   tt  - 打开终端
"   v   - 可视模式（选中当前行）
"   w   - 保存
"   x   - 保存并退出
"   y   - 复制到剪贴板
"   z   - 折叠相关

" 窗口导航:
"   Ctrl-h/j/k/l     - 窗口间跳转
"   Ctrl-Shift+h/j/k/l - 调整窗口大小

" ============================================================================
" 结束
" ============================================================================
