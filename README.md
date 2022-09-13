# 致第一次安装 Rime 的你

此文档是原贴 [致第一次安装 Rime 的你](http://tieba.baidu.com/p/3288634121) 分享链接的迁移。

# 一、用户界面选项

## 1.1 Rime Setting 界面

![Rime Setting UI](/Users/john/Library/Rime/images/image-20220818113438900.png)

#### 1.1.1、 Deploy「部署」

对用户配置文件的修改每次均需通过此按钮使配置生效

#### 1.1.2、 Sync user data 「同步用户资料」

后面讲

#### 1.1.3、 Settings 「打开用户设置文件夹」
不同平台下用户配置文件夹路径如下：

【中州韻】 ibus-rime → Linux
【小狼毫】 Weasel → Windows
【鼠鬚管】 Squirrel → Mac OS X

Windows
Weasel: %APPDATA%\Rime
Mac OS X
Squirrel: ~/Library/Rime
Linux
iBus: ~/.config/ibus/rime
Fcitx: ~/.config/fcitx/rime

## 1.2 GUI [user.yaml](https://github.com/rime/home/wiki/UserData)

![gui](./images/rime_gui.png)

通过 GUI 界面，我们可以设置一些最为基本的设置，如选择拼音输入方案（默认为朙月拼音），
以及简繁体切换半角全角切换等。

#### 1.2.1、 简繁切换

![简繁转换](./images/简繁转换.gif 'Optional title')

#### 1.2.2、 方案选择

![方案选单](./images/方案选单.gif 'Optional title')

#### 1.2.3、 全角半角切换

![全角半角切换](./images/全角半角切换.gif 'Optional title')

以上三选项均可通过 `user.yaml` 进行设置

```yaml
var:
  option:
    full_shape: false # 半角
    simplification: true # 简体
  previously_selected_schema: luna_pinyin # 输入方案为朙月拼音
```

# reference

搜狗细胞词库 [Rime 输入法简中用户新手套餐](https://github.com/ACsediment/RimeNewbie)
[Rime 词库扩展计划](https://github.com/Iorest/rime-dict)

https://github.com/rime/home/wiki/SharedData

https://github.com/rime/home/wiki/UserData

【中州韻】 ibus-rime → Linux
【小狼毫】 Weasel → Windows
【鼠鬚管】 Squirrel → Mac OS X
