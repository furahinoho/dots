"######################################
" 未分類
scriptencoding utf-8
set history=10000
set backspace=indent,eol,start
set virtualedit+=block "set virtualedit=all
set grepprg=grep\ --binary-files=without-match\ --color=auto\ --exclude-dir=.git\ --exclude-dir=.svn\ --exclude=.tags\ --exclude=tags\ --exclude=cscope.out\ --exclude=dependency.list\ --exclude=.depend\ --exclude=Makefile

"######################################
" 補完
set infercase
" コマンドライン
" ファイル名補完で無視するパターン
set wildignore+=*.a,*.o,*.obj
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png
set wildignore+=*.DS_Store,.git,.hg,.svn,.tag
set wildignore+=*.swp,*.pdf

set wildignorecase
set wildmode=list:longest,full

"######################################
" 検索
set nowrapscan
set ignorecase
set smartcase

"######################################
" 表示全般
set background=dark
set display=lastline
set lazyredraw
set novisualbell
set nowrap
set pumheight=20
"======================================
" カラースキーム
" see)
" :e $VIMRUNTIME/colors/desert.vim
" :so $VIMRUNTIME/syntax/colortest.vim
highlight Comment   ctermfg=LightMagenta
highlight Constant  NONE
highlight PreProc   ctermfg=LightGreen
highlight Search    ctermfg=Black         ctermbg=LightCyan
highlight Statement ctermfg=LightGreen
highlight Type      ctermfg=LightGreen
" ポップアップメニュー
highlight Pmenu     ctermfg=Black     ctermbg=LightGray   
highlight PmenuSel  ctermfg=LightGray ctermbg=Black     cterm=Bold
highlight PmenuSbar ctermfg=LightGray ctermbg=Black     cterm=Bold
" 空白
set listchars=tab:>-,trail:~
function! ZenkakuSpace()
  highlight ZenkakuSpace ctermfg=DarkGray cterm=underline
endfunction
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd colorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    autocmd VimEnter,WinEnter * match ZenkakuSpace '\%u3000'
  augroup END
  call ZenkakuSpace()
endif
" 対応する括弧の強調
set showmatch
set matchtime=1

"######################################
" バックアップ
set backup
set backupdir=$HOME/tmp/vim
autocmd BufReadPost * let &backupext= '%' . strftime('%m%d-%H%M') . substitute(expand('%:p:h'), '/', '%', 'g')
let directory=&backupdir

"######################################
" 整形
set textwidth=0 " 自動折り返ししない
augroup SetupFormatOptions
  " formatoptionsはsetlocalで設定する
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=cort
  autocmd BufEnter * setlocal formatoptions+=B
augroup END

" インデント
set autoindent
set copyindent
set expandtab
set preserveindent
set shiftwidth=2
set smartindent
set smarttab
set softtabstop=0 "0:tabstopと同値とする
set tabstop=2

" C言語系のファイルはハードタブにする
" C++専用でいいのでは
"set path+=,/usr/include
augroup FiletypeDetect
  autocmd!
  autocmd BufEnter *.c,*.cpp,*.java,*.go setlocal tabstop=4 shiftwidth=4
augroup END

"######################################
" 日本語
set ambiwidth=double
set fileencoding=utf-8 nobomb
set fileencodings=utf-8,sjis,iso-2022-jp,cp932,euc-jp,ucs-bom,ucs-2le,ucs-2,latin1
set fileformats=unix
set fileformats=unix,dos,mac

"######################################
" マッピング
" 事故防止
nnoremap ZZ <NOP>
nnoremap ZQ <NOP>
nnoremap Q  <NOP>

" プレフィクスキーの定義
nnoremap  [prefix0] <NOP>
nnoremap  <SPACE>   <NOP>
nmap      <SPACE>   [prefix0]
nnoremap  [prefix1] <NOP>
nnoremap  s         <NOP>
nmap      s         [prefix1]

" 検索
nnoremap # #N
nnoremap * *N
nnoremap n nzz
nnoremap N Nzz

" 最近使ったファイル
nnoremap <silent> [prefix0]r :oldfile<CR>:e #<

" 設定スイッチトグル
nnoremap <silent> [prefix0]p :setlocal paste!   \| set paste?<CR>
nnoremap <silent> [prefix0]n :setlocal number!  \| set number?<CR>
nnoremap <silent> [prefix0]w :setlocal wrap!    \| set wrap?<CR>
nnoremap <silent> [prefix0]s :setlocal list!    \| set list?<CR>
nnoremap <silent> [prefix0]h :setlocal nohsearch<CR>

" バッファ
nnoremap <silent> [prefix0]j :bnext<CR>
nnoremap <silent> [prefix0]k :bprevious<CR>
nnoremap <silent> [prefix0]d :bdelete<CR>
nnoremap <silent> [prefix0]D :bdelete!<CR>
nnoremap <silent> [prefix0]l :buffers<CR>:buffer 
nnoremap <silent> [prefix0]t :tabnew %<CR>

" コマンドラインモード
"************************************
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <Esc><C-B> <S-Left>
cnoremap <Esc><C-F> <S-Right>

" バッファパス
cnoremap <C-X> <C-r>=expand('%:p:t')<CR>
cnoremap <C-Z> <C-r>=expand('%:p:h')<CR>

"######################################
" QuickFix
function! s:ToggleQuickfixWindow()
  let pre_window_count = winnr('$')
  cclose

  if(pre_window_count == winnr('$'))
    cwindow
  endif
endfunction
nnoremap <silent> [prefix0]w :<C-u>call <SID>ToggleQuickfixWindow()<CR>
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vimgrepadd,cscope if len(getqflist()) == 0 | cclose | else | copen | endif

nnoremap <silent> [prefix0]n :cnext<CR>zz
nnoremap <silent> [prefix0]p :cprevious<CR>zz
nnoremap <silent> [prefix0]N :clast<CR>
nnoremap <silent> [prefix0]P :crewind<CR>
nnoremap <silent> [prefix0]C :cexpr ""<CR>

" LocationList
function! s:ToggleLocationWindow()
  let pre_window_count = winnr('$')
  lclose

  if(pre_window_count == winnr('$'))
    lwindow
  endif
endfunction
nnoremap <silent> [prefix1]w :<C-u>call <SID>ToggleLocationWindow()<CR>

nnoremap <silent> [prefix1]n :lnext<CR>zz
nnoremap <silent> [prefix1]p :lprevious<CR>zz
nnoremap <silent> [prefix1]N :llast<CR>
nnoremap <silent> [prefix1]P :lrewind<CR>
nnoremap <silent> [prefix1]C :lexpr ""<CR>

"######################################
" netrw
let g:newrw_list_hide='\.[ao],^\.[^.]'
let g:newrw_liststyle=1

"######################################
" tags
" 1) ./.tags バッファと同じディレクトリを探す
" 2) .tags;$HOME カレントディレクトリを探す。みつからなかったら$HOMEまで遡って探す
set tags=./.tags,.tags;$HOME

"######################################
" ステータスライン
set statusline=%t%M%R%=\ \|\ %5l/%5L\ %3p%%;%4v;%{&fileencoding};bomb\ %{&bomb};%{&fileformat}
set laststatus=2

"######################################
" IME制御 TODO
"" 挿入モードに入る時，前回の挿入モードにおける IME の状態を復元する．
"set t_SI+=[<r
"" 挿入モードを出る時，現在の IME の状態を保存し，IME をオフにする．
"set t_EI+=[<s[<0t
"" Vim 終了時，IME を無効にし，無効にした状態を保存する．
"set t_te+=[<0t[<s
"" ESC キーを押してから挿入モードを出るまでの時間を短くする
"set timeoutlen=100

"######################################
" プロジェクト専用の設定を読み込む
"source $PRJRC/.vimrc
