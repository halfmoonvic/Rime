### 致第一次安装Rime的你
##### 一、简介
此配置时原贴 [致第一次安装Rime的你](http://tieba.baidu.com/p/3288634121) 分享链接的迁移。  原教程最早的时候在word上编辑书写，原也打算将其转换为md格式，但太懒，便一直懈怠着。  
根据不同的时间节点发布的配置，我均以分支的形式保留下来，用户在点进下述一些配置链接之后可直接点击右上角绿色按钮 <span style="background: #0f0;color:#fff">`Clone or download`</span> 进行下载使用。

##### 二、第一份配置
分支 [`<config-2014/09/10>`](https://github.com/halfmoonvic/Rime/tree/config-2014/09/10)   
文件中的配置文档与word教程同步发布即 2014/9/10
其中配置与教程书写顺序完全吻合。

##### 三、第二份配置
分支 [`<config-2016/02/28>`](https://github.com/halfmoonvic/Rime/tree/config-2016/02/28)   中的配置是在我初次使用小狼毫后，自己在逐渐的使用过程中添加了部分词典颜文字等功能。  
如luna_pinyin.phrase.dict.yaml词典等，更为实用。  
此份配置大体与word教程吻合，只是在特殊标点符号上面做了改进。  
关于此，我不会在就其进行修改（因为关于特殊符号的修改本就比较复杂些，没有必要）。而欲了解改进详情机制的同学
可以查看我在知乎发布的答案—— [Rime 输入法有比较现成的设置吗？](https://www.zhihu.com/question/20871256/answer/34365902?from=profile_answer_card)。里面做了阐述
为了方便学习，新配置文档中各个配置均做了注释。

##### 四、第三份配置
分支 [`<config-2018/11/03>`](https://github.com/halfmoonvic/Rime/tree/config-2018/11/03)  
第三份配置所做的主要针对新版小狼毫(0.11.1)所做的兼容，添加新版emoji（旧版的emoji我没有移除，仍然保留在内），默认输入法列表只包含 朙月拼音。 <del>鼠须管同时也要在进行编译，可见 [How to Rime with Squirrel](https://github.com/rime/squirrel/blob/master/INSTALL.md)。编译完成之后进行替换操作，如下：</del>

- 先停用（输入源里移除鼠须管，等替换完成后再添加回来）「鼠须管」；
- Finder 定位到 /Library/Input Methods 用下载的编译版本替换旧的程序；
- 右键运行一次替换的新程序，给它提权（在 app 上右键选择「打开」）；
- 输入源中添加「鼠须管」重新部署即可。

**注意**
鼠须管 发布了新版 `0.11.0 (2019-01-21)`，用户可不在进行上述编译替换操作，直接在 [官网](https://rime.im/download/) 下载安装即可
