#!/bin/bash
set -e
trap 'echo "BiliHelper 安装失败, 请检查网络链接, 如有需要请自备梯子"' ERR
# Environment Config
TERMUX_PATH=$HOME/.termux
TERMUX_PROPS=$TERMUX_PATH/termux.properties
BHP_CONF_PATH=$HOME/storage/shared/bhpConf
BHP_CONF=$BHP_CONF_PATH/user.conf

cd $HOME

# Setup Extra Keys Rows
setupExtKey() {
    if [ ! -d $TERMUX_PATH ]; then
        mkdir $TERMUX_PATH
    fi
    if [ ! -f $TERMUX_PROPS ]; then
        echo "extra-keys = [['ESC','|','/','HOME','UP','END','PGUP','DEL'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN','BKSP']]" >> $TERMUX_PROPS
        echo >> $TERMUX_PROPS
    else
        echo "文件 $TERMUX_PROPS 已存在, 跳过..."
    fi
}

# Backup Config File
backupConf() {
    echo
    echo "正在备份外部配置文件..."
    if [ -f $BHP_CONF ]; then
        mv $BHP_CONF $BHP_CONF.bak
        echo "原配置文件已备份为 user.conf.bak"
    else
        echo "未发现外部配置文件, 跳过..."
    fi
}

# Update & Install Pre-required
updIns() {
    echo
    echo "正在升级 Termux 内部程序..."
    yes | pkg update
    echo
    echo "正在安装 BiliHelper 必需程序..."
    yes | pkg install curl git php

    echo
    echo "正在安装 Composer..."
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'c5b9b6d368201a9db6f74e2611495f369991b72d9c8cbd3ffbc63edff210eb73d46ffbfce88669ad33695ef77dc76976') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
    mv composer.phar $PREFIX/bin/composer
}

# Install BHP
bhpIns() {
    echo
    echo "正在安装 BiliHelper..."
    if [ -d bhp ]; then
        rm -rf bhp
    fi
    git clone https://github.com/lkeme/BiliHelper-personal.git bhp
    cd bhp
    composer install
    if [ ! -d $BHP_CONF_PATH ]; then
        mkdir -p $BHP_CONF_PATH
    fi
    cp conf/user.conf.example $BHP_CONF

    cd $HOME
    echo
    echo "BiliHelper 已安装完毕, 请按照教程编辑手机内部储存根目录中 bhpConf/user.conf 文件配置 BiliHelper"
}

setupExtKey
backupConf
updIns
bhpIns
