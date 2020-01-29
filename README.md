# Termux -x- BiliHelper 教程

## 前言

1. 感谢 [Lkeme](https://github.com/lkeme) 的 [BiliHelper-personal](https://github.com/lkeme/BiliHelper-personal)

1. 文中所有蓝色文字均为超链接，看到可以直接点击蓝色文字链接进入对应页面或直接下载文件

1. 如有需要请自备梯子

## 下载并安装 Termux

### 方法一: 使用 Google Play

1. 打开页面 [Termux](https://play.google.com/store/apps/details?id=com.termux) 跳转到 Google Play 下载并安装

### 方法二: 从 F-Droid 手动下载安装

1. 打开页面 [Termux](https://f-droid.org/packages/com.termux/)

   *注: 最新版本 0.88, 支持 Android 7.0 以上系统*

1. 在页面点击蓝色 **Download APK** 开始下载 Termux

1. 安装下载好的安装包

### 方法三: 从酷安手动下载安装

1. 打开页面 [Termux 高级终端](https://www.coolapk.com/apk/com.termux)

   *注: 最新版本 0.73, 支持 Android 5.0 以上系统*

1. 在页面点击绿色 **下载APK** 开始下载 Termux

1. 安装下载好的安装包

## 配置 Termux (可用于更新 BiliHelper)

### 使用脚本自动配置 Termux

1. 下载保存 [自动配置 BHP x Termux 脚本](https://github.com/0x012FA733/BHP-Termux/raw/dev/deploy.sh)

1. 复制到手机储存根目录

1. 打开 Termux

   *注: 第一次打开 Termux 可能需要加载, 请等待加载完成*

1. 在 Termux 的终端输入

   ```
   termux-setup-storage
   ```

   在弹出的对话框给予 Termux 允许访问储存装置的权限

1. 在 Termux 的终端继续输入

   ```
   bash $HOME/storage/shared/deploy.sh
   ```

   *注:*

   *1. Termux 中长按屏幕可以复制 (Copy) 和粘贴 (Paste)*

   *2. 下载的文件默认文件名为 `deploy.sh`, 路径为手机储存根目录, 如果更改了路径或文件名请自己对应修改上面命令 (手机储存根目录: `$HOME/storage/shared/`)*

1. 等待配置脚本运行完毕

## 配置 BiliHelper

### 编辑方法

使用任意文件管理工具, 以 **文本文件方式** 打开手机储存根目录下 `bhpConf/user.conf` 文件进行编辑

### 设置介绍

如需修改设置, 请直接修改各个设置等号后面部分即可

#### 账户设置

- `APP_USER` 用户名(必需), 填入你的用户名, 建议前后各加上一个双引号

- `APP_PASS` 密码(必需), 填入你的密码, 建议前后各加上一个双引号

   *注: 令牌部分自动生成, 请勿填写任何内容*

#### 其他设置

- 请参考 `user.conf` 内说明自行修改, 后果自负

## 启动 BiliHelper

### 使用脚本启动 BiliHelper

1. 下载保存 [运行 BHP x Termux 脚本](https://github.com/0x012FA733/BHP-Termux/raw/dev/start.sh)

1. 复制到手机储存根目录

1. 打开 Termux

1. 在 Termux 的终端输入

   ```
   bash $HOME/storage/shared/start.sh
   ```

   *注:*

   *1. Termux 中长按屏幕可以复制 (Copy) 和粘贴 (Paste)*

   *2. 下载的文件默认文件名为 `start.sh`, 路径为手机储存根目录, 如果更改了路径或文件名请自己对应修改上面命令 (手机储存根目录: `$HOME/storage/shared/`)*

1. 脚本运行启动 BiliHelper

   *注:*

   *1. 当任意配置文件不存在, 脚本将使用默认配置文件*

   *2. 使用默认配置文件, 请求输入用户名或密码时不支持符号 "\\" (反斜杠), 输入密码时你的密码不会显示在屏幕上*

### 常见问题

1. **空白的账号和口令!** 或 **登录失败, 账号或者密码错误**

   -  使用外部配置文件启动

      请检查手机储存根目录下 `bhpConf/user.conf` 文件是否输入了正确的用户名和密码

   -  使用内部配置文件 / 默认配置启动

      在 Termux 中输入命令 `bash $HOME/storage/shared/start.sh -r` 清除内部配置文件, 重新输入正确的用户名和密码

1. 更新 BiliHelper

   1. 在 Termux 中输入命令 `bash $HOME/storage/shared/deploy.sh` 运行, 即可自动更新到最新版本 BiliHelper

   1. 重新设置外部配置文件; 如配置文件无更新, 可以把备份配置文件 `user.conf.bak` (位于手机储存根目录下的 `bhpConf` 文件夹内) 重命名为 `user.conf`

   1. 继续在 Termux 中输入命令 `bash $HOME/storage/shared/start.sh` 运行, 即可启动 BiliHelper