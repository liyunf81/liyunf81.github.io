---
layout: post
title: Unity3D Shader 入门笔记
category: 技术
tags: Shader 
keywords: Unity3D ,Shader , 入门
description:
---

### 初衷
刚接触Unity3D 不久，最近被分配做项目的一个编辑器，涉及到shader 和材质，方便美术可以实时的查看
修改材质后的效果。于是就有了这篇笔记，它脱胎于This is an [猫都能学会的Unity3D Shader入门指南](http://onevcat.com/2013/07/shader-tutorial-1/).

Unity3D 所有的渲染都离不开Shader.我们可以从Shader的手册和文档开始出发来学习Shader(比如[这里](http://docs.unity3d.com/Manual/Shaders.html),[这里](http://docs.unity3d.com/Manual/Built-inShaderGuide.html)
[这里](http://docs.unity3d.com/Manual/SL-Reference.html))
这只是一个笔记，如果您是高手，请您不要评论。

### 基本概念
#### Shader 和 Material 

我们进行3D开发，想必对这两个词都不会太陌生。Shader 实际上就是一小段程序，它负责将输入的Mesh以指定的方式
和输入的贴图或者颜色等组合作用，然后输出。绘图单元可以依据这个输出来讲图像绘制到屏幕中。
而将输入的贴图或者颜色等，加上对应的Shader,以及对Shader的特定参数设置，将这些内容打包存储在一起，
得到的就是一个Material。之后，我们便可以将材质赋予合适的Render 来进行渲染输出了。

Shader大体上可以分为两类，简单来说
* 表面着色器- 为你做了大部分的工作
