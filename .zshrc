# 文字コードの設定
export LANG=ja_JP.UTF-8

export SVN_EDITOR="vi"

# AWS environment
export AWS_AUTO_SCALING_HOME=/Users/shikataka/aws/AutoScaling
export AWS_CLOUDWATCH_HOME=$HOME/aws/CloudWatch
export AWS_CREDENTIAL_FILE=$HOME/aws/credential-file
export SERVICE_JVM_ARGS="-Dhttp.proxyHost=http://133.242.17.38 -Dhttp.proxyPort=9191" 

export JAVA_HOME=/Library/Java/Home

export LDFLAGS=-L/usr/local/opt/sqlite/lib
export CPPFLAGS=-I/usr/local/opt/sqlite/include
export NDK_ROOT=/Users/shikataka/Applications/android-ndk-r9
export ANDROID_HOME=/Applications/sdk

PATH=$(brew --prefix josegonzalez/php/php54)/bin:/usr/local/bin:/usr/local/sbin:/Users/shikataka/bin/sh:/opt/local/bin:/opt/local/sbin:/Applications/sdk/platform-tools:/Users/shikataka/Applications/android-ndk-r9:/Users/shikataka/perl5/bin/:${AWS_AUTO_SCALING_HOME}/bin:${AWS_CLOUDWATCH_HOME}/bin:/usr/local/Cellar/ruby/2.0.0-p247/bin:/Applications/sdk/tools:$PATH
export MANPATH=/usr/local/share/man:/usr/local/man:/usr/share/man
#export PHP_HOME=$HOME/local/php/versions
#source $(brew --prefix php-version)/php-version.sh && php-version 5.4.12 >/dev/null

# 関数
find-grep() {
	find . -type f -print | xargs grep -n --binary-files=without-match $@
}

source ~/.zshrc.antigen

# エイリアスの設定
alias ls='ls -G'
alias ll='ls -ltr'
alias gd='dirs -v; echo -n "select number: "; read newdir; cd +"$newdir"'
alias cp='cp -r -p'

# プロンプトの設定 
PROMPT='%~# '

# ヒストリの設定
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# 履歴ファイルに時刻を記録
setopt extended_history

# 補完するかの質問は画面を超える時にのみに行う｡
LISTMAX=0

autoload -Uz compinit; compinit

# sudo でも補完の対象
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# cdのタイミングで自動的にpushd
setopt auto_pushd 

# 複数の zsh を同時に使う時など history ファイルに上書きせず追加
setopt append_history

# 補完候補が複数ある時に、一覧表示
setopt auto_list

# 保管結果をできるだけ詰める
setopt list_packed

# 補完キー（Tab, Ctrl+I) を連打するだけで順に補完候補を自動で補完
setopt auto_menu

# カッコの対応などを自動的に補完
setopt auto_param_keys

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# ビープ音を鳴らさないようにする
setopt no_beep

# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups

# ヒストリにhistoryコマンドを記録しない
setopt hist_no_store

# 余分なスペースを削除してヒストリに記録する
setopt hist_reduce_blanks

# 行頭がスペースで始まるコマンドラインはヒストリに記録しない
# setopt hist_ignore_spece

# 重複したヒストリは追加しない
# setopt hist_ignore_all_dups

# ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify

# auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示しない
setopt no_list_types

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs

# 8 ビット目を通すようになり、日本語のファイル名を表示可能
setopt print_eight_bit

# シェルのプロセスごとに履歴を共有
setopt share_history

# Ctrl+wで､直前の/までを削除する｡
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# ディレクトリを水色にする｡
export LS_COLORS='di=01;36'

# ファイルリスト補完でもlsと同様に色をつける｡
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# cd をしたときにlsを実行する
function chpwd() { ls }

# ディレクトリ名だけで､ディレクトリの移動をする｡
setopt auto_cd

# C-s, C-qを無効にする。
setopt no_flow_control

# rvm
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#[[ -s "/Users/shikataka/.rvm/scripts/rvm" ]] && source "/Users/shikataka/.rvm/scripts/rvm"  # This loads RVM into a shell session.

#
# Show branch name in Zsh's right prompt
#

autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

setopt prompt_subst
setopt re_match_pcre

function rprompt-git-current-branch() {
        local name st color gitdir action
        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
                return
        fi
        name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
        if [[ -z $name ]]; then
                return
        fi

        gitdir=`git rev-parse --git-dir 2> /dev/null`
        action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

        st=`git status 2> /dev/null`
	if [[ "$st" =~ "(?m)^nothing to" ]]; then
                color=%F{green}
	elif [[ "$st" =~ "(?m)^nothing added" ]]; then
                color=%F{yellow}
	elif [[ "$st" =~ "(?m)^# Untracked" ]]; then
                color=%B%F{red}
        else
                 color=%F{red}
         fi

              
        echo "$color$name$action%f%b "
}

RPROMPT='[`rprompt-git-current-branch`%~]'

# gitのエイリアス
alias gst='git status -s && git stash list'
alias gch='git cherry -v'
alias glgg='git logg'
alias git='nocorrect git'
# gcc
#export CC=/usr/bin/gcc-4.2
#if [ -f ~/.bashrc ] ; then
#	. ~/.bashrc
#fi
PROMPT='@%m %c# '

function command_not_found_handler() {
	echo "(´・ω・｀)> $0 ってコマンド見つからないよ"
}

function do_enter() {
		if [ -n "$BUFFER" ]; then
	        zle accept-line
	        return 0
	    fi
	    echo
	    ls
	    # ↓おすすめ
	    # ls_abbrev
	    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
	        echo
	        echo -e "\e[0;33m--- git status ---\e[0m"
	        git status -sb
	    fi
	    zle reset-prompt
	    return 0
}
zle -N do_enter
bindkey '^m' do_enter
