alias cnpm="npm --registry=https://registry.npm.taobao.org \
  --cache=$HOME/.npm/.cache/cnpm \
  --disturl=https://npm.taobao.org/dist \
  --userconfig=$HOME/.cnpmrc"

alias cls="clear"

# 原始密码登录跳板机
alias jumper="ssh mayongbin@jumper.sankuai.com"

# 秘钥登录跳板机
alias jp="ssh -i ~/.ssh/id_rsa_jumper mayongbin@jumper.sankuai.com"

# alias jadetrans
alias trans="jadetrans"
# alias vps
alias vps=""
# alias dump
alias dump="jmap -dump:live,format=b,file=/tmp/dump.hprof $(pgrep java)"
# meituan npm image
alias mnpm="npm --registry=http://r.npm.sankuai.com \
--cache=$HOME/.cache/mnpm \
--disturl=http://npm.sankuai.com/mirrors/node \
--userconfig=$HOME/.mnpmrc"

alias ge=graph-easy

# run all junit tests
alias jtest="mvn test"
