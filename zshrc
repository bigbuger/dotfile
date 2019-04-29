export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

#自动补全功能
fpath=(~/.zsh/completion $fpath)
eval "`pip2 completion --zsh`"
setopt AUTO_LIST
setopt AUTO_MENU
setopt MENU_COMPLETE

autoload -U compinit
compinit

#打错命令时提示
setopt correct

#自动刷新
zstyle ':completion:*' rehash true
#自动补全缓存
#zstyle ':completion::complete:*' use-cache on
#zstyle ':completion::complete:*' cache-path .zcache
#zstyle ':completion:*:cd:*' ignore-parents parent pwd

#自动补全选项
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' select-prompt '%SSelect: lines: %L matches: %M [%p]'

zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

#路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'
zstyle ':completion::complete:*' '\\'

#修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
#错误校正
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

#kill 命令补全
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

#补全类型提示分组
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
zstyle ':completion:*:corrections' format $'\e[01;32m -- %d (errors: %e) --\e[0m'

#关于历史纪录的配置 {{{
#历史纪录条目数量
export HISTSIZE=1000
#注销后保存的历史纪录条目数量
export SAVEHIST=1000
#历史纪录文件
export HISTFILE=~/.zhistory
#以附加的方式写入历史纪录
setopt INC_APPEND_HISTORY
#如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_ALL_DUPS
#为历史纪录中的命令添加时间戳
setopt EXTENDED_HISTORY

#启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt AUTO_PUSHD
#相同的历史路径只保留一个
setopt PUSHD_IGNORE_DUPS

#在命令前添加空格，不将此命令添加到纪录文件中
#setopt HIST_IGNORE_SPACE
#}}}



autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git*' actionformats "%s:[%b|%a]"
zstyle ':vcs_info:git*' formats "%s:[%b]"
precmd() {
    vcs_info
}

autoload -U promptinit
promptinit
setopt prompt_subst
autoload -U colors && colors
export PROMPT='%F{cyan}.--%f%F{magenta}%n%f@%F{magenta}%m%f: %F{yellow}%~ %S${vcs_info_msg_0_}%s%f '$'\n''%F{cyan}\`-->%f '


setopt completealiases

#命令别名
#alias cp='cp -i'
#alias mv='mv -i'
#alias rm='rm -i'
alias ls='ls -G'
alias ll='ls -l'
alias grep='grep --color=auto'
alias tree='tree -C'

export VIRTUAL_ENV_DISABLE_PROMPT=1

export HASKELLPATH=$HOME/Library/Haskell
export GOPATH=$HOME/go
export PATH=$PATH:$(go env GOPATH)/bin:$HASKELLPATH/bin
export PATH=$PATH:$HOME/Library/Python/3.7/bin
#export PATH=$HOME/.local/bin:$PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/an/.sdkman"
[[ -s "/Users/an/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/an/.sdkman/bin/sdkman-init.sh"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ -z "$INSIDE_EMACS" ]; then
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

# zsh-bd
. $HOME/.zsh/plugins/bd/bd.zsh

source /usr/local/share/zsh/site-functions/git-flow-completion.zsh 
