# coding dir
export CODING_DIR=/Users/archer/coding

# go
export GOPATH=$CODING_DIR/go
export PATH="$GOPATH/bin:$PATH"

# java8
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_192.jdk/Contents/Home
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_80.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"

# maven
export M2_HOME=/Users/archer/coding/software/maven
export PATH="$M2_HOME/bin:$PATH"

# node
export NODE_HOME=/usr/local/Cellar/node@12/12.18.3
export PATH="$NODE_HOME/bin:$PATH"

source "$HOME/.cargo/env"
