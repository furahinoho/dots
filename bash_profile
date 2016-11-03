######################################
# TAB補完
# 指定したサフィックスのファイル無視する
export FIGNORE=${FIGNORE}.o:.svn:.git

######################################
# .bash_history
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTIGNORE='?:??:???:????:rm *:rmdir *:history:exit:logout:kill *:pkill *:man *'

######################################
# misc
export LANG=ja_JP.UTF-8
export EDITOR=vim
export VISUAL=$EDITOR
export EMAIL=$USER@local.area.net
export USER_TMP=$HOME/tmp
export USER_LOG_DIR=$USER_TMP/log

######################################
# UI
export TERM=xterm-256Color
export COLORFGBG='15;0'
export PS1='\[\033[0;33m\]\$\[\033[0m\] '

######################################
# path
export PATH=$PATH:$HOME/opt/bin:$HOME/local/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/opt/lib:$HOME/local/lib
# 擬似クリップボード
export CLIPBOARD=SHOME/.CLIPBOARD

######################################
# coreutils options
export LESS='--hilite-search --ignore-case --LONG-PROMPT --QUIET --RAW-CONTROL-CHARS --jump-target=5 --no-init --quit-if-one-screen'
export BC_ENV_ARGS="--quiet $HOME/.bcinit"
export SCREENDIR=$HOME/.screen

######################################
# MPC
export MPD_HOST=localhost
export MPD_PORT=52800

######################################
# git
export GIT_COMMITTER_NAME=$USER
export GIT_AUTHOR_NAME=$USER

######################################
# Subversion
export SVN_EDITOR=$EDITOR

######################################
# Go Language
export GOPATH=$HOME/opt:$HOME/local
export PATH=$PATH:$HOME/opt/bin:$HOME/local/bin

######################################
# .bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

######################################
# プロジェクト専用の起動コマンド
export PRJRC=SHOME/.prjrc.d
[[ -f $PRJRC/bash_profile ]] && . $PRJRC/bash_profile

######################################
# XWindow起動
[[ -z $DISPLAY  && $XDG_VTNR -eq 1 ]] && exec startx
