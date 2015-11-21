---
layout: post
title: 凨眼电子书开源项目记录
category: 技术
tags: iOS,Swift,电子书,开源,凨
description:
---
最近一直在学swift，也一直琢磨着,想写一个项目来巩固所学。
契机是有一天突然翻到大学快毕业的时候，写的一个半成品ios小说阅读器。
于是突然决定把它完成。然后说干就干，开始了swift的苦逼自学事业。

## 第一天
项目构架一直在思考，由于本人中途放弃ios跑去做游戏了。后来呵呵女票分了后，突然意识到自己所有生活都是给了公司,然后毅然辞职。
磕磕盼盼的走了过来，最后还是发现好好把技术打磨，也是算一个不太坏的出路。废话不多说，开始正题。
项目的构架采用了前人的轮子和自己的一点点经验。

* UI层采用 MMVM (使用ReactiveCocoa来作为事件传递)
* 网络层采用Alamofire：它是AFNetworking库作者在swfit中的实现
* 数据缓存则采用sqlite，和基本的userdefults,当然这个的自己封装
* 至于发布和部署之类的还太早，经验也有限，做到哪一步在考虑。
* 音效层：自己打算封装一层，可能会很差，不过也想学学如何用，这里面可能有一个非常鸡肋的音乐播放功能，嘿嘿，为什么说鸡肋呢，因为现在音乐播放器都可以后台运行。

ui层的布局则考虑使用代码加xib的形式，当然代码会使用第三方库Masonry来管理约束，苹果自带的约束自我感觉就是反人类的设计，难用 ~ ~。
然后hub提示则采用非常非常有名的MBProgressHUD,这个大家应该都用过,不多表述.
动画类的呢，就考虑用Facebook的开源库pop,这个库我看了很久了，但是一直没有决心采用它，但是这次本来是为了巩固知识于是就大胆用了。
谈到这里，突然想到了。用cocopods管理swift库需要注意的地方。那就是需要在podfile里加上use_frameworks!因为swift不支持静态库，所以必须有这个选项.
就比如我项目里面的podfile:

	pod 'Masonry'
	use_frameworks!

由于在国内swift还不怎么流行，很多第三方库都还没有出现，于是只能用OC的代替。这里面就会涉及到一个非常关键的.h文件，它的作用就是方便swift和OC之间进行桥接。可以在swift端使用OC的代码。
这里面创建它的最简便方法就是随便创建一个OC类，然后xcode就会弹出一个提示（这里就不提示图片了，后续看有时间补上）.点击确定就会创建.最后创建的文件名FBook-Bridging-Header.h。只需要在这个里面import你需要的OC类头文件，或者库文件，就可以在swift端使用了。

然后就是非常坑爹的代码习惯了。现在写什么都习惯OC方式，就比如申明变量:总喜欢以类型名字开头、？和!总是分不清到底什么地方使用合适，swift 高级部分一直使用不到，代理，封包，等等都感觉我在以OC方式写swift..
不过我想随着代码的前行，这些东西会慢慢改善吧。。

		2015-11-22 01：04 周日  凨