---
layout: post
title: Objective-C 简介
category:技术
tags:ios
keywords:ios,Objective-C,
description:

---

  Objective-C 是一个非常简单的计算机语言，在C语言的基础上扩展了面向对象编程。它提供了类的定义，协议，代理等。类的语法和设计主要基于Smalltalk，它是最早的面向对象编程语言之一。
  
  如果以前学过其他面向对象语言，那么一些基本概念可以帮助你学习Objective-C的基本语法。例如传统的面向对象概念，封装；继承；多态。
  如果你没有任何编程语言的知识，不用担心，因为这个小博文就是Objective-C的基本入门。如果你想要学习IOS相关知识，后续会有介绍。
  
  
##C的超集
Objective-C 是标准C语言的超集，支持所有的C语法。在C语言中，一般都会把声明和定义放在不同地方。声明置放于头文件，定义置放于源文件(一般以.c为后缀)。

而Objective-C：.h 同C一样，是其类和变量的声明部分，.m则是源文件，可包含Objective-C和C的代码。 .mm 也是源文件。当且仅当你需要使用C++类或者特性的时候才使用此扩展名。

你可以使用标准的#include 编译选项 来包含头文件。但是推荐使用Objective-C提供的#import：它能够确保相同的文件只会被包含一次。

##基本数据类型
基本数据类型同C相同，主要有int,long,float,double,char,void bool 等。在Objective-C的最基本类库Foundation中还定义了一些别名:NSInteger,CGFloat,BOOL等。所有基本类型的内存管理都和C相同。

##字符串
Objective-C支持所有的C语言字符串方面的约定。也就是说，单引号包含的为字符，双引号包含的为字符串，且以\0为结束..但是在写Objective-C代码时，大部分不会使用C语言风格的字符串，而会使用NSString。NSString提供了字符串的类包装。包含了很多优点；支持对任意长度的字符串内存管理机制，支持UniCode等等。因为这种字符串使用的非常之频繁。Objective-C提供了@助记符来创建常量字符串。比如 
	NSString* aString = @"这是一个OC字符串";
	NSString* stringFromCString = [NSString stringWithCString:"A C String" encoding:NSASCIIStringEncoding];
	
##面向对象
###类声明和定义
就如同其他所有面向对象语言一样，类是OC(此后Objective-C都以OC为简称)用来封装数据，以及操作数据行为的结构。而对象则是类在运行期间的实例。
OC定义包括了定义和实现两个部分。分别在.h以及.m中实现。
类声明总是以@interface开始，@end结束 比如
	@interface MyClass :NSObject 
	{
		int _member;
		...
	}
	
	-(id)initWithMember:(int) aMember;
	+(id)CradteWithMember:(int)aMember;

上面的MyClass 就是我们声明的类了。NSObject则是父类，我们所有的OC类型都继承自此类。后面的则分别为成员变量和方法声明。 

类的定义是以@implementation 和 @end 成对出现。所有实现则在其中间。类的实现如下:
	@implementation 
	-(id)initWithMember:(int) aMember
	{
		self = [super init];
		if(nil != self)
		{
			_member = aMember;
		}
		return self;
	}
	
	+(id)CradteWithMember:(int)aMember
	{
		return [[ [MyClass alloc] initWithMember:aMember]autorelease];
	}
	
	@end
	
OC规定 类的所有实例都需要用指针类型来保存和使用。它支持强弱两种类型。强类型指针的变量声明，包含了类名。弱类型指针使用id作为对象的类型。就比如前面类声明中一样。

###方法
OC可以声明两种方法：实例方法，和类方法（也叫静态方法）。实例方法，它在具体的实例中执行。也就是说你想要执行某个实例方法，你需要先创建类的实例。而类方法则不需要。可以直接使用类名加方法调用。具体的规则和注意事项将在后续博文介绍。

###属性
OC中的属性，就我而言，我认为其实就是为了更为方便的使用，替代了直接调用获取方法。使得代码跟为简洁，易读。而且跟容易维护。
实际上属性节约了你必须写的大量代码。因为大多数存取方法都是类似的。属性避免了为类暴露的每个实例变量提供不同的setter和getter的需求。取而代之的却是，你用属性声明你希望的行为，然后在编译期间，编译器为你自动生成setter和getter方法。
基本的定义可以使用@property来进行声明属性。（在4.5以前的编译器还需要在源文件.m中出现对应的@synthesize才能声明为属性）

##协议和代理
协议声明了可以被任何类执行的方法。它不是具体的类。如果你使用过C#或者java那么就会很清楚接口这一词。协议就是同接口一样。协议只是定义一些方法声明。而其他对象负责去实现。你实现了协议里面的方法。则叫做遵循协议或者符合协议。

协议的声明和类的声明很像。但是协议没有父类，而且不能定义任何实例变量。如:
	@protocol MyProtocol
	-(void)isTest;
	@end

##总结
暂时就介绍这一些东西。后期可能会接触到OC的内部实现，如何从C的基础上扩展出面向对象的概念。KVO,KVC,MVC等等。可能还会涉及到Foundation的一些常用类，以及IOS的一些framework..