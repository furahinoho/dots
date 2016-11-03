" .vimrcの設定が無視される項目は再設定する {{{
set visualbell t_vb=
execute 'colorscheme ' . g:jkns_colorscheme
" }}}

" 全般 {{{
if v:servername == 'VIEWER'
  set guioptions=
elseif v:servername == 'CRAWLER'
else
  if has('unix')
    " タイトルバー不要
    set guioptions=cC
  else
    set guioptions=c
  endif

  " gVimでもテキストベースのタブページを使う
  set guioptions-=e

endif
" }}}

" ウィンドウサイズと位置の記憶と復元 {{{
let g:save_window_file = expand('$JKNS_VIMTMP/.vimwinpos')
augroup SaveWindow
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = [
      \ 'set columns=' . &columns,
      \ 'set lines=' . &lines,
      \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
      \ ]
    call writefile(options, g:save_window_file)
  endfunction
augroup END

if filereadable(g:save_window_file)
  execute 'source' g:save_window_file
endif
" }}}

"" 縦幅　デフォルトは24
"set lines=40
"" 横幅　デフォルトは80
"set columns=120
"
"" 最大化して起動する
"autocmd GUIEnter * simalt ~x

" font {{{
" カンマ区切りで設定すると、最初に利用できたものを採用するようだ
"   最終手段はMSゴシックか
if has('win32') || has('win64')
" フォント名に日本語名を使うので、一時的に文字コードを変える
"  set encoding=cp932
"  set guifontwide=メイリオ:h14:cDEFAULT,MS\ Gothic:h12
"  set guifont=Consolas:h14:cANSI,IBM3270:h14:cANSI,MS\ Gothic:h12
" 元に戻す
"  set encoding=utf8

  set guifontwide=MS\ Gothic:h11
  set guifont=Consolas:h11:cANSI

elseif has('unix') ||  has('win32unix')
"  set guifontwide=VL\ ゴシック\ 12,Takaoゴシック\ 12
  set guifontwide=YOzFontCF\ Light\ 12
  set guifont=M+\ 1m\ 12
endif
" }}}

" 透過処理 {{{
"augroup hack234
"  autocmd!
"  if has('mac') || has('win32') 
"    autocmd FocusGained * set transparency=255
"    autocmd FocusLost * set transparency=80
"  endif
"augroup END
"}}}


" Mouse:"{{{
"
" Show popup menu if right click.
set mousemodel=popup

" Don't focus the window when the mouse pointer is moved.
set nomousefocus
" Hide mouse pointer on insert mode.
set mousehide

"}}}

" tab line {{{
"******************************************************************************
" 個別のタブの表示設定をします
function! GuiTabLabel()
  " タブで表示する文字列の初期化をします
  let l:label = ''

  " タブに含まれるバッファ(ウィンドウ)についての情報をとっておきます。
  let l:bufnrlist = tabpagebuflist(v:lnum)

  " 表示文字列にバッファ名を追加します
  " パスを全部表示させると長いのでファイル名だけを使います 詳しくは help fnamemodify()
  let l:bufname = fnamemodify(bufname(l:bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')
  " バッファ名がなければ No title としておきます。ここではマルチバイト文字を使わないほうが無難です
  let l:label .= l:bufname == '' ? 'No title' : l:bufname

"  " タブ内にウィンドウが複数あるときにはその数を追加します(デフォルトで一応あるので)
"  let l:wincount = tabpagewinnr(v:lnum, '$')
"  if l:wincount > 1
"    let l:label .= '[' . l:wincount . ']'
"  endif

  " このタブページに変更のあるバッファがるときには '[+]' を追加します(デフォルトで一応あるので)
  for bufnr in l:bufnrlist
    if getbufvar(bufnr, "&modified")
      let l:label .= '[+]'
      break
    endif
  endfor

  " 表示文字列を返します
  return l:label
endfunction

" guitablabel に上の関数を設定します
" その表示の前に %N というところでタブ番号を表示させています
"set guitablabel=%N:\ %{GuiTabLabel()}
"set tabline=%{GuiTabLabel()}

"function! GuiTabLabel()
"  " タブで表示する文字列の初期化をします
"  let l:label = ''
"
"  " タブに含まれるバッファ(ウィンドウ)についての情報をとっておきます。
"  let l:bufnrlist = tabpagebuflist(v:lnum)
"
"  " 表示文字列にバッファ名を追加します
"  " パスを全部表示させると長いのでファイル名だけを使います 詳しくは help fnamemodify()
"  let l:bufname = fnamemodify(bufname(l:bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')
"  " バッファ名がなければ No title としておきます。ここではマルチバイト文字を使わないほうが無難です
"  let l:label .= l:bufname == '' ? 'No title' : l:bufname
"
"  " タブ内にウィンドウが複数あるときにはその数を追加します(デフォルトで一応あるので)
"  let l:wincount = tabpagewinnr(v:lnum, '$')
"  if l:wincount > 1
"    let l:label .= '[' . l:wincount . ']'
"  endif
"
"  " このタブページに変更のあるバッファがるときには '[+]' を追加します(デフォルトで一応あるので)
"  for bufnr in l:bufnrlist
"    if getbufvar(bufnr, "&modified")
"      let l:label .= '[+]'
"      break
"    endif
"  endfor
"
"  " 表示文字列を返します
"  return l:label
"endfunction
" }}}
