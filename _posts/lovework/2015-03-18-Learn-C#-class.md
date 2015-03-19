---
layout: post
title: 了解C#类-Class
category: 技术
tags: C#
keywords: C#,Class,类
description:
---

在C#中一使用诸如class的关键字词来进行类定义。   
申明类

    public class CustomClass
    {
        //类主体,一般会有数据，和行为
    }

class 前面的public 为类的访问级别，类的名称为CustomClass
下图为C#现存的类型访问控制修饰符
![控制修饰符](http://7x2xd3.com1.z0.glb.clouddn.com/class.png)
>当父类和子类在同一个程序集的时候，internal成员为可见，当父类和子类
在不同一个程序集的时候，子类不能访问父类的internal成员，但能访问父类的
protected internal
class 的默认修饰符为internal.
sealed:这个是密封类表示此类不能被继承，也就是说它绝对不能作为抽象类使用。
partial:可以声明在不同文件中的同一个类。

创建好了类，使用关键字new创建对象
如:

    CustomClass customObj = new CustomClass();
    1.CustomClass() 是一个默认的构造函数，
    2.new CustomClass() 创建了对象，并将引用地址返回给customObj.

类的字段，属性，和索引
字段可以理解为，类的变量，常量，用以存储该类实例的相关数据
在C++中我们称这些为成员变量。

    public class Date
    {
        private int _year;
        private int _month;
        private int _day;
    }

大多数情况，字段的修饰符我们都会赋予private,当然也可以使用其他的比如
public ，这样在类之外都可以访问(修改，读取)这个字段。但是不建议这样
应该通过属性或者方法来访问类中的字段数据。

属性的任务就是将类的字段数据暴露给类之外，并且可以起到检测和更错的作用。
    
    public class Date
    {
        private int _year;
        private int _month;
        private int _day;

        public int Year
        {
            get 
            {
                return _year;
            }

            set 
            {
                _year = value;
            }
        }

        public int Month
        {
            get
            {
                return _month;
            }

            prvate set 
            {
                _month = value;
            }
        }

        public int Day
        {
            get 
            {
                return _day;
            }
        }
    }

看上面代码，我们定义了三个属性，Year,Month,Day.
>Year 为可读可写
Month 也是可读可写，但是写只能在类的内部。
Day为只读属性

索引就类似于数组的取值操作。

    public class MyClass
    {
        public string this[int index]
        {
            get 
            {
                return "X" + index.ToString();
            }
        }
    }


方法是包含一系列语句的代码块，用于表示类可以有的一系列操作。
事件 在发生其他类或者对象关注的事件时，类或对象可通过事件通知告知它们。

运算符重载

    public class Chemical
    {
        ...
        public static Chemical operator+(Chemical c1,Chemical c2)
        {
            ...
        }
    }

>这里的+运算符重载是静态的。
比较运算符必须成对出现，也就是说重载了==，必须重载!=。<和>以及<=和>=同样如此。

构造函数 每个类都必须有一个构造函数，它用于初始化类实例。其访问级别一般是public。
构造函数无返回值，可重载。
如果构造函数的访问级别为private.那么就为私有构造函数了。 
包含私有构造函数的类，一般只包含静态成员，也就是说，它基本不会实例化对象。
私有构造函数的目的，往往是用来阻止利用默认构造函数。

析构函数
析构函数是当对象将从内存中移除时由运行库执行引擎调用的。通常用来释放一些资源。
>一个类只能有一个析构函数。
无法继承或重载析构函数。
无法调用析构函数。

继承 C#只能从一个类中继承，如果需要进行多类继承，可考虑使用接口继承来间接实现。
继承可传递，但是构造函数，和析构函数不能被继承。

同一个作用域，同一个方法名称，具有不同的参数类型或者参数个数，在调用时，根据
参数自动决定使用哪一个方法。这就是方法重载。

隐藏，下面看下代码：
	public class BaseClass
	{
		public string GetString()
		{
			return "这是基类的一个方法";
		}
	}
	
	public class DerivedClass: BaseClass
	{
		pubilc new string GetString()
		{
			retrun "这是隐藏了基类GetString()的方法";
		}
	}
	

可以看出来使用关键字new来做到隐藏基类的方法.

方法重写，一般作用为多态性。
在基类的一个方法前面有virtual，那么此方法为一个虚方法，表示这个方法可以被重写。
override 用在派生类中，表示可对基类的虚方法重写。

当我们队一个问题分析的越深入，发现结构会越来越抽象。当抽象出问题的一个统一方法时，一般会将其放在一个抽象类中，并且将这个方法作为一个虚方法，方便其他子类重写。
说道抽象类，那么不得不说下接口。
那么什么情况下使用抽象类，什么情况下使用接口呢？
接口的目的是提供一个标准给大家使用，可以是在不同类别之间，比如烟花和火箭。他们都有一个发射接口。
而抽象的目的是我无法实现它，由继承我的类来实现。那么就要求是同属一个类型。

	public abstract class Phone //手机抽象类
	{
		public abstract void call();
		public abstract void Photo();
		public abstract void Net();
	}
	
通过这种设计，那么就会要求每一个手机都必须拥有上面的功能。如果我不实现这些，那么这个类就无法创建成功。
如果改用接口呢。

	public interface PhoneInterface
	{
		void Call();
	}
	
	public interface PhotoInterface
	{
		void Photo();
	}
	
	public interface NetInterface
	{
		void Net();
	}
	
	public class Phone : PhoneInterface
	{
		...
	}
	
	public class Phone1 : PhotoItnterface,PhoneInterface
	{
		...
	}
	
	

