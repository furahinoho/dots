# 非対話モードならばここで終了する。シェルスクリプト実行時に意図しない動作を防ぐため
[[ $- != *i* ]] && return

# $HOME/.bash_profileで設定しているが、/etc/bash.bashrcで上書きされるのでさらに上書き
export PS1='\[\033[0;33m\]\$\[\033[0m\] '

# 非対話モード（viのコマンドラインなどからの呼び出し）でもエイリアスや関数を扱えるように
#export BASH_ENV=$HOME/.bashrc
#shopt -s expand_aliases

######################################
# 補完
# バス名展開で、アルフアベットの大小を区別しない
shopt -s nocaseglob
# バス名展開で、`**'を有効にする
shopt -s globstar
# ディレクトリ名を展開する
shopt -s direxpand
# `@'が含まれている場合、ホスト名の補完を行う
shopt -s hostcomplete
# 未入力の場合、補完しない
shopt -s no_empty_cmd_completion

# 履歴編集失敗時にも内容を残す
shopt -s histreedit
# "!"でのコマンド再利用前に確認する
shopt -s histverify
# cdの引数でディレクトリでないものは変数名とみなす
shopt -s cdable_vars

#######################################
# Readline
# Ctrl + S無効。（画面更新の停止）
stty stop undef
# Ctri + Q無効。（画面更新の再開。停止を無効にしているので、この機能も不要）
stty start undef
# Ctrl + w無効。（有効だとreadlineのunix-filename-ruboutが有効にできない）
stty werase undef
# 他は$HOME/.inputrcで定義する。libreadlineを利用しているものに適用するため

#######################################
# alias
# 事故防止、利便性のためにオプション設定する
#alias rm='rm --interactive=once'
alias rm='trash'
alias mv='mv --interactive'
alias cp='cp --interactive'
alias ln='ln --interactive'

alias ls='ls --color=auto --indicator=none'
alias la='ls --almost-all'
alias ll='ls -l --human-readable --classify'
alias lla='ls -l --human-readable --classify --almost-all'

GREP_BASE_OPTIONS='--binary-files=without-match --color=auto --exclude-dir=.git --exclude-dir=.svn --exclude=.tags --exclude=tags --exclude=cscope.out --exclude=dependency.list --exclude=.depend --exclude=Makefile'
alias grep='grep --ignore-case $GREP_BASE_OPTIONS'
alias Grep='\grep $GREP_BASE_OPTIONS' # 大文字小文字を区別する
alias cgrep='grep --color=always' # リダイレクト先に色制御文字も渡す。lessで色付きで表示できる

alias dstat-full='dstat -Tclmdrn'
alias dstat-mem='dstat -Tclm'
alias dstat-cpu='dstat -Tclr'
alias dstat-net='dstat -Tclnd'
alias dstat-disk='dstat -Tcldr'

# ディレクトリ移動支援
alias jumplist-add='echo $(pwd) >> $HOME/.JUMPLIST'
alias jumplist-edit='vim $HOME/.JUMPLIST'
alias j='cd $(cat SHOME/.JUMPLIST veco); pwd'
alias k='cd .. ; pwd'
alias kk='cd ../.. ; pwd'

# handbook
complete -F _comp_func_handbook handbook
_comp_func_handbook() {
  COMPREPLY=($(compgen -W "$(ls $HOME/.handbook)" -- "${cur}"))
}

# veco 連携
#READLINE_LINE
#READLINE_POINT
#veco-history() {
#    local NUM=$(history | wc -l)
#    local FIRST=$((-1*(NUM-1)))
#
#    if [ $FIRST -eq 0 ] ; then
#        history -d $((HISTCMD-1))
#        echo "No history" >&2
#        return
#    fi  
#
#    local CMD=$(fc -l $FIRST | sort -k 2 -k 1nr | uniq -f 1 | sort -nr | sed -E 's/^[0-9]+[[:blank:]]+//' | veco | head -n 1)
#echo $CMD
#    if [ -n "$CMD" ] ; then
#        history -s $CMD
#    else
#        history -d $((HISTCMD-1))
#    fi  
#}
#bind -x '"\C-r":veco-history'

######################################
# screen
# 多重起動防止して自動起動
#if [ "X"`which screen 2> /dev/null` != "X" -a $SHLVL -eq 1 ];then
# screen
#fi
