scriptencoding utf-8
" ========================================================================
" bwangel 的 vimrc
" 我的博客： https://www.bwangel.me/
"
" 许可：GPLv3
" ========================================================================


" Initial Plugin 加载插件[[[1
" ===========================

" 加载插件
" 非兼容Vi模式
set nocompatible

" 修改leader按键
let mapleader = ' '
let g:mapleader = ' '

set shell=bash

" 开启语法高亮
syntax on

if filereadable(expand("~/.vim/vimrc.bundles"))
    source ~/.vim/vimrc.bundles
endif


filetype plugin indent on
"]]]

" General Settings 基础设置[[[1
" =============================

"文件自动重新载入
set autoread
set updatetime=500
au CursorHold * checktime

" history存储容量
set history=2000

" 监测文件类型
filetype on

" 针对不同的文件类型，使用不同的缩进格式
filetype indent on

" 允许插件
filetype indent on

" 取消备份
set nobackup

" 突出显示当前列
set cursorcolumn
" 突出显示当前行
set cursorline
" 设置80行提示线
set colorcolumn=80

" 设置退出VIM后，内容显示在屏幕
set t_ti= t_te=

" 改变终端标题
set title
" 去掉输入错误的提示音
set novisualbell
set noerrorbells
set t_vb=
set tm=500

" 关闭时记住打开Buffer的信息
set viminfo^=%

" 正则表达式打开magic
set magic

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
" 转折换行的配置
set whichwrap+=<,>

" 离开当前Buffer,或者失去焦点的时候，就保存所有的buffer
" au BufLeave,FocusLost * wa

" 开启鼠标
set mouse=a

if has('mac')
    let g:python3_host_prog = '/usr/local/bin/python3'
else
    let g:python3_host_prog = '/usr/bin/python3'
endif

" ]]]

" Display Settings 展示/排版等界面格式设置[[[1
" ============================================

" 显示当前行号列号
set ruler
" 在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前Vim模式
set showmode

if has("gui_macvim")
    " 设置 MacVim 的行号
    set guifont=Monaco:h14
    " MacVim 移除滚动条
    set guioptions=
    " MacVim 关闭鼠标闪烁
    " set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkon0
    set gcr=a:blinkon0              "Disable cursor blink

	function GuiTabLabel(n)
	  return "[". a:n . "]" . fnamemodify(getcwd(1, a:n), ':t')
	endfunc

	" 设置tabline显示的内容为当前目录
	function MyTabLine()
      let s = ''
      for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
          let s .= '%#TabLineSel#'
        else
          let s .= '%#TabLine#'
        endif

        " set the tab page number (for mouse clicks)
        let s .= '%' . (i + 1) . 'T'

        " the label is made by MyTabLabel()
        let s .= ' %{GuiTabLabel(' . (i + 1) . ')} '
      endfor

      " after the last tab fill with TabLineFill and reset tab page nr
      let s .= '%#TabLineFill#%T'

      " right-align the label to close the current tab page
      if tabpagenr('$') > 1
        let s .= '%=%#TabLine#%999Xclose'
      endif

      return s
    endfunction

	set tabline=%!MyTabLine()
endif

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=7

" 状态栏信息 [
    set laststatus=2

    " statusline说明
    "
    " %{}: {}中可以存放一个表达式
    " \ : 空格

    set statusline=
    " %<: 如果内容被截断，前面用<填充
    " %f: buffer中的文件路径
    set statusline+=%<
    " %m: 修改标记[+]，如果'modifiable'选项关闭的话是[-]
    " %r: 只读标记[RO]
    " %w: 预览窗口标记[Preview]
    " %h: 帮助Buffer的标记[help]
    " %y: Buffer中文件的类型，例如[vim]
    set statusline+=\ %m%r%w%h%y
    " %l: 当前行号 %c: 当前列号，特殊字符算作一列，中文算作三列
    set statusline+=\ %(%l,%c%)
    " %P: 文档阅读百分比 %L: 文档总行数
    set statusline+=\ %P-%L
    " %n: Buffer序号
    set statusline+=\ \<%n\>
    " %B: 光标下字符的十六进制编码值
    set statusline+=\ %B
    " %{ALEGetStatusLine()}: ALE代码检查状态
    set statusline+=\ %{ale#engine#IsCheckingBuffer(bufnr('%'))?'[♫]':'[●]'}
    " set statusline+=\ %{ALEGetStatusLine()}

    " %=: 左右对齐项目的分割点
    set statusline+=\ %=

    "  (&fenc==\"\")?&enc:&fenc: fileencoding表示Buffer中打开的文件编码，encoding表
    " 示vim使用的文件编码，默认显示fileencoding
    "  (&bomb?\",BOM\":\"\"): 检查当前文件中是否含有BOM标记
    "  > BOM标记是一个二进制标记符，用来表示字节流的编码标号或字节序,参考
    "  > https://zh.wikipedia.org/wiki/%E4%BD%8D%E5%85%83%E7%B5%84%E9%A0%86%E5%BA%8F%E8%A8%98%E8%99%9F
    set statusline+=[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]
    " %{fugitive#statusline()}: 利用tpope/vim-fugitive插件获取当前Git分支
    set statusline+=\ %{(exists('g:loaded_fugitive')?fugitive#statusline():'')}
" ]

set isfname-==

" 显示行号
set number
" set relativenumber
" nmap <C-N><C-N> :set relativenumber!<CR>
" augroup numbertoggle
"   autocmd!
"   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"   autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
" augroup END

" 取消换行
set nowrap

" 括号配对情况, 跳转并高亮一下匹配的括号
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2

" 文内搜索相关的设置
" 高亮search命中的文本
set hlsearch
" 打开增量搜索模式,随着键入即时搜索
set incsearch
" 搜索时忽略大小写
set ignorecase
" 有一个或以上大写字母时仍大小写敏感
set smartcase

" 代码折叠
set foldenable
set foldmethod=indent
set foldlevel=99

" 缩进配置
" Smart indent
set smartindent
" 打开自动缩进
" never add copyindent, case error   " copy the previous indentation on autoindenting
set autoindent

" tab相关设置
" 设置Tab键的宽度        [等同的空格个数]
set tabstop=4
" 每一次缩进对应的空格数
set shiftwidth=4
" 按退格键时可以一次删掉 4 个空格
set softtabstop=4
" insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set smarttab
" 将Tab自动转化成空格[需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set expandtab
" 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'
set shiftround

" A buffer becomes hidden when it is abandoned
set hidden

set ttyfast

" 00x增减数字时使用十进制
set nrformats=
" ]]]

" FileEncode Settings 文件编码,格式[[[1
" =====================================
" 设置新文件的编码为 UTF-8
set encoding=utf-8
" 自动判断编码时，依次尝试以下编码：
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" 下面这句只影响普通模式 (非图形界面) 下的 Vim
set termencoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m
" 合并两行中文时，不在中间加空格
set formatoptions+=B
" ]]]

" others 其它设置[[[1
" ===================

" 自动补全配置
" 让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt=menuone,longest,menu,preview
imap <c-space> <c-x><c-o>

" ex模式下补全的方式
set wildmode=list:longest
" 增强模式中的命令行自动完成操作
set wildmenu
" Ignore compiled files
set wildignore=*.swp,*.bak,*.pyc,*.class,.svn,.git,node_modules,*~,*.o
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" 离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" quickfix window  s/v to open in split window,  ,gd/,jd => quickfix window => open it
autocmd BufReadPost quickfix nnoremap <buffer> v <C-w><Enter><C-w>L
autocmd BufReadPost quickfix nnoremap <buffer> s <C-w><Enter><C-w>K

" command-line window
autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>

" 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" ]]]

" HotKey Settings  自定义快捷键设置[[[1
" =====================================
"Treat long lines as break lines (useful when moving around in them)
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" 功能键的键位映射[[[2
" ====================

" F1 设置行号
noremap <F1> :set number!<CR>"

" F2 折叠开关
function! ToggleFold()
    if(&foldlevel == '0')
        exec "normal! zR"
    else
        exec "normal! zM"
    endif
    echo "foldlevel:" &foldlevel
endfunction
nnoremap <F2> :call ToggleFold()<CR>

" F3 is used to Open or Close NERDTree
" 见vimrc.bundles:389

" F4 换行开关
nnoremap <F4> :set wrap! wrap?<CR>

" F5 插入模式下的粘贴开关
set pastetoggle=<F5>            "    when in insert mode, press <F5> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
" F5 查看 undo 历史树
" nnoremap <F5> :UndotreeToggle<cr>

" F6 语法开关，关闭语法可以加快大文件的展示
nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

" F7 快速运行dot生成png文件
" nnoremap <F7> :!dot -Tpng -o %<.png % && open %<.png<CR>
map <F7> :call RunSrc()<CR><CR>
func! RunSrc()
    exec "w"
    if &filetype == 'py'||&filetype == 'python'
        exec "!PYTHONPATH="." python %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    elseif &filetype == 'go'
        exec "!go build -o /tmp/go_built .;/tmp/go_built"
    elseif &filetype == 'ruby'
        exec "!ruby %"
    elseif &filetype == 'markdown'
        exec "!markdown_py %>md_exported.html;google-chrome md_exported.html"
    elseif &filetype == 'dot'
        exec "!dot -Tpng -o %<.png %"
    endif
    exec "e! %"
endfunc

" F8 为tagbar显示导航栏的快捷键
" 见vimrc.bundles:691

" F9 显示可打印字符开关
set listchars=tab:›-,trail:•,extends:#,nbsp:f,eol:$
nnoremap <F9> :set list! list?<CR>

" F10 自动格式化当前代码
map <F10> :call FormartSrc()<CR>
func! FormartSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi --one-line=keep-statements -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "r !autopep8 -i % > /dev/null 2>&1"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    endif
    exec "e! %"
endfunc

" F11 用于 LSP
" ]]]

" Tab 按键设置[[[2
" ================

" tab 操作
" http://vim.wikia.com/wiki/Alternative_tab_navigation
" http://stackoverflow.com/questions/2005214/switching-to-a-particular-tab-in-vim

" normal模式下切换到确切的tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Toggles between the active and last active tab "
" The first tab is always 1 "
let g:last_active_tab = 1
nnoremap <silent> <leader>tt :execute 'tabnext ' . g:last_active_tab<cr>
autocmd TabLeave * let g:last_active_tab = tabpagenr()

" 新建tab  Ctrl+t
nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <Esc>:tabnew<CR>


" ]]]

" c-x c-x => git grep the word under cursor
let g:gitgrepprg="git\\ grep\\ -n"
let g:gitroot="`git rev-parse --show-cdup`"

function! GitGrep(args)
    let grepprg_bak=&grepprg
    exec "set grepprg=" . g:gitgrepprg
    execute 'silent! grep "\<' . a:args . '\>" ' . g:gitroot
    botright copen
    let &grepprg=grepprg_bak
    exec "redraw!"
endfunction

func! GitGrepWord()
    normal! "zyiw
    call GitGrep(getreg('z'))
endf

nmap \ :call GitGrepWord()<CR>

" 分屏窗口移动, Smart way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
nnoremap <C-v> <C-w>v
nnoremap <C-c> <C-w>c
nnoremap <C-s> <C-w>s

" 屏幕左右滑动的快捷键
" 需要考虑Mac下zl和zh的映射
nnoremap <M-Right> zl
nnoremap <M-Left> zh
nnoremap <S-Right> zL
nnoremap <S-Left> zH

" 插入模式下将小写字母转换成大写字母, I love this very much
inoremap <C-y> <esc>gUiwea

" 将%:h映射为%%，%:h的功能是显示当前缓冲区文件的绝对路径
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'

" Go to home and end using capitalized directions
noremap H ^
noremap L $

" 命令行模式增强，ctrl - a到行首， -e 到行尾，ctrl - b表示左移
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
" ctrl-n, ctrl-p 只能搜索历史命令
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" 进入搜索Use sane regexes"
nnoremap / /\m
vnoremap / /\m

" Keep search pattern at the center of the screen.
nnoremap <silent> n n
nnoremap <silent> N N
nnoremap <silent> * #Nzz
nnoremap <silent> # *Nzz
nnoremap <silent> g* g*zz

" In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" for # indent, python文件中输入新行时#号注释不切回行首
autocmd BufNewFile,BufRead *.py inoremap # X<c-h>#

" 切换前后buffer
nnoremap [b :bprevious<cr>
nnoremap ]b :bnext<cr>
" 使用方向键切换buffer
noremap <left> :bp<CR>
noremap <right> :bn<CR>

" 调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv

" 添加 Tmux 的支持
if $TMUX == ''
    set clipboard+=unnamed
endif

" 复制选中区到系统剪切板中
if has('clipboard')
    vnoremap y "+y
    map Y "+y$
else
    " y$ -> Y Make Y behave like other capitals
    map Y y$
endif

" w!! to sudo & write a file
cmap w!! w !sudo tee >/dev/null %

" Quickly save the current file
nnoremap <leader>w :w<CR>
nnoremap <leader>r :e<CR>
" https://github.com/wsdjeg/vim-galore-zh_cn#%E6%99%BA%E8%83%BD-ctrl-l
" nnoremap <leader>r :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" 交换 ' `, 使得可以快速使用'跳到marked位置
nnoremap ' `
nnoremap ` '

" 将U映射成<C-r>
nnoremap U <C-r>

" nnoremap <leader>o o<esc>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>e :e $MYVIMRC<cr>
" nmap <silent> <leader>s :so $MYVIMRC<CR>
nmap <silent> <leader>u :e ~/.vim/vimrc.bundles<CR>

if has("gui_macvim")
    " 前后切换tab
    " noremap <S-L> :tabnext<CR>
    " noremap <S-H> :tabprev<CR>

    " Switch to specific tab numbers with Command-number
    noremap <D-1> :tabn 1<CR>
    noremap <D-2> :tabn 2<CR>
    noremap <D-3> :tabn 3<CR>
    noremap <D-4> :tabn 4<CR>
    noremap <D-5> :tabn 5<CR>
    noremap <D-6> :tabn 6<CR>
    noremap <D-7> :tabn 7<CR>
    noremap <D-8> :tabn 8<CR>
    noremap <D-9> :tabn 9<CR>
    " Command-0 goes to the last tab
    noremap <D-0> :tablast<CR>
endif


" 文件折叠
nmap - zc
nmap + zo

" 文件重新载入
nnoremap R :e <CR>

" 获取当前位置作为断点
function! GetBreakPoint()
    let @* = expand("%").":".line(".")
    echo @*
endfunction

nmap <leader>b :call GetBreakPoint()<CR>

" ]]]

" FileType Settings  文件类型设置[[[1
"====================================

" 具体编辑文件类型的一般设置，比如不要 tab 等
autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown set filetype=markdown.mkd wrap
autocmd BufRead,BufNewFile *.part set filetype=html

" 定义函数AutoSetFileHead，自动插入文件头
autocmd bufnewfile *.c so ~/.vim/templates/c.template
autocmd bufnewfile *.py so ~/.vim/templates/python.template
autocmd bufnewfile *.ruby so ~/.vim/templates/ruby.template
autocmd bufnewfile *.cpp so ~/.vim/templates/cpp.template
autocmd bufnewfile *.sh so ~/.vim/templates/sh.template
autocmd bufnewfile *.vim so ~/.vim/templates/vim.template
autocmd bufnewfile *.go so ~/.vim/templates/go.template
" 设置可以高亮的关键字
if has("autocmd")
  " Highlight TODO, FIXME, NOTE, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\||BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(INFO\|IDEA\|NOTICE\)')
    " 这里TIPS表示做的笔记, DESC表示代码的描述
    " autocmd Syntax * call matchadd('level1c', '\W\zs\(TIPS\|DESC\)')
  endif
endif
" ]]]

" Theme Settings  主题设置[[[1
"=============================

" theme主题和背景透明度
if &diff
    colorscheme industry
else
    set background=dark
    set t_Co=256
    colorscheme solarized
endif


" 设置标记一列的背景颜色和数字一行颜色一致
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" for error highlight，防止错误整行标红导致看不清
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline
" ]]]


" vim:fdm=marker:fmr=[[[,]]]
" vim:foldlevel=99
" 自动更新vimrc文件
