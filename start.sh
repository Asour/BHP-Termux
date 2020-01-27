#!/bin/bash
set -e
# Environment Config
BHP_CONF=$HOME/storage/shared/bhpConf/user.conf
EXEC_CONF_PATH=$HOME/bhp/conf
EXEC_CONF=$EXEC_CONF_PATH/user.conf

cd $HOME

# Remove Config File
rmConf() {
    if [ -f $EXEC_CONF ]; then
        rm $EXEC_CONF
    fi
}

# Check Config File
checkConf() {
    if [ -f $BHP_CONF -a -d $EXEC_CONF_PATH ]; then
        echo "发现外部配置文件, 将使用外部配置文件启动 BiliHelper"
        cp $BHP_CONF $EXEC_CONF
    elif [ -f $EXEC_CONF ]; then
        echo "发现内部配置文件, 将使用内部配置文件启动 BiliHelper"
    elif [ -d $EXEC_CONF_PATH ]; then
        echo "配置文件不存在, 将按默认配置启动 BiliHelper"
        echo '注: 用户名或密码含有字符 "\" 请使用外部配置文件'
        cp $EXEC_CONF_PATH/user.conf.example $EXEC_CONF

        read -p "请输入用户名: " USERNAME
        if [ ! $USERNAME == '' ]; then
            sed -i '/APP_USER=/d' $EXEC_CONF
            sed -i '6iAPP_USER=\"'$USERNAME'\"' $EXEC_CONF
        fi
        echo -n "请输入密码: "
        read -s PASSWORD
        if [ ! $PASSWORD == '' ]; then
            sed -i '/APP_PASS=/d' $EXEC_CONF
            sed -i '7iAPP_PASS=\"'$PASSWORD'\"' $EXEC_CONF
        fi
    else
        echo "配置文件路径不存在, 请确认正确安装 BiliHelper"
        exit 0
    fi
}

run() {
    cd bhp
    php index.php
}

while getopts 'r' OPT; do
    case ${OPT} in
    r )
        rmConf
    ;;
    \? )
        echo "Usage:"
        echo "  start.sh [options]"
        echo
        echo "Options:"
        echo "  -r  删除内部配置文件"
        exit 0
    ;;
    esac
done
checkConf
run
