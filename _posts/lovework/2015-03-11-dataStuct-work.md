---
layout: post 
title: C#项目中数据类型的选择
category: 技术
tags: C#
keywords: C#,数据结构,Data Struct
description: 记录关于C#数据类型以及研究 值类型和引用类型的区别
---

C#项目中数据类型的选择
---------------------
  当使用内置的数据类型时，考虑数据的最大数据范围，数据需要的精度，操作，etc.来确定使用什么样的类型.
比如Int 有符号的整型的取值范围为2147483647~-2147483648 所以在这个范围之间的数据都可以选择此数据类
型。当然也可以考虑一些其他的数据类型。

    在这，突然想到有想要深入了解下C#的基本数据类型.首先了解一点:C#认可的基础数据类型并没有内置于C#
    语言中，而是内置于.net framework中.就如假如我们声明一个int型变量时，声明的实际是.net结构
    System.Int32的一个实例.这就是为什么C#的基本数据类型却可以想我们自定义类一样使用一些方法.
    C#现阶段有15个预定类型，其中13个是值类型，两个是引用类型.(问:此处的值类型和引用类型有什么区别？
    什么是值类型？什么事引用类型?，使用它们需要注意一些什么?)

### 1、整型
| 类型名字           |.net类型               |说明               |取值范围                             |
| ------------------ |:---------------------:|:-----------------:|------------------------------------:|
| sbyte              |System.Sbyte           |8位有符号的整型    |-128~127(2^7 ~ 2^7-1)                |
| short              |System.Int16           |16位有符号整型     |-32768~32767(2^15 ~ 2^15-1)          |
| int                |System.Int32           |32位有符号整型     |-2147483648~2147483647(2^35 ~ 2^35-1)|
| long               |System.Int64           |64位有符号整型     |-2^63 ~ 2^63 -1                      |
| byte               |System.Byte            |8位无符号整型      |0~255(0 ~ 2^8-1)                     |
| ushort             |System.UInt16          |16位无符号整型     |0~2^16-1                             |
| uint               |System.UInt32          |32位无符号整型     |0~2^32-1                             |
| long               |System.UInt64          |64位无符号整型     |0~2^64-1                             |

### 2、浮点类型
| 类型名字           |.net类型               |说明               |取值范围                             |
| -------------------|:---------------------:|:-----------------:|------------------------------------:|
|float               |System.Single          |小数点精度为7      |±1.5 × 10-45 到 ±3.4 × 1038          |
|double              |System.Double          |小树点进度为15到16 |±5.0 × 10-324 到 ±1.7 × 10308        |
>说明:double 数据类型的精度是float数据类型精度的2倍左右.如果在代码中没有对浮点型数据进行硬编码(12.3)则
 编译器默认此数据为double类型.如果想要使其为float则可以在数据后面加上f或者F
  ```
  float f = 12.5f;
  ```

### 3、decimal类型
| 类型名字           |.net类型               |说明                    |取值范围                             |
| -------------------|:---------------------:|:----------------------:|------------------------------------:|
|decimal             |System.Decimal         |128位高进度10进制表示法 |±1.5 × 10-45 到 ±3.4 × 1038          |
>说明:decimal类型专用于进行财务类计算或者一些复杂的涉及到进度非常高的数学计算.
 要把一个数据定义为decimal类型，需要在数字后面添加字符M或者m 如:
 ```
 decimal d = 211.55m;
 ```

### 4、bool类型和char类型
| 类型名字           |.net类型               |说明                     |取值范围                             |
| -------------------|:---------------------:|:----------------------: |------------------------------------:|
| bool               |System.Boolean         |表示true或者false        |true or false                        |
| char               |System.Char            |表示一个16位的Unicode字符|-32768~32767                         |

>说明:上面的数据类型都是数值类型

### 5、object 和 string类型
| 类型名字           |.net类型               |说明                     |取值范围                             |
| -------------------|:---------------------:|:----------------------: |------------------------------------:|
| object             |System.Object          |所有数据类型的基         |                                     |
| string             |System.String          |字符串                   |                                     |

### 6、引用类型和数值类型
  在C#中设计类型的时候，就需要决定类型实例的行为，这样才能做到逻辑清晰，易维护。在使用C#制作项目时，需要正确理解
值类型和引用类型的区别。变量是值类型还是引用类型往往都有其数据类型决定，所以清楚哪些数据类型是值类型，哪些是引用
类型非常有必要.

#### 6.1、值类型
 1. C#中所有值类型都隐式派生自System.ValueType.
 2. 结构体struct直接派生自System.ValueType.
 3. 枚举enum 派生自System.Enum.
 4. 可空类型System.Nullable<T>泛型结构

>此处联想到一个问题:既然所值类型都派生自System.ValueType.也就是说它们其实也是一个类结构，那么我是否可以派生自这
 些类型呢？答案是不能的，因为所有这些值类型都是密封的(seal)的.这里补充下密封类的概念。
 C#中使用关键字sealed，将类和方法声明为密封类或者密封方法，密封类表示不能被继承，但是可以继承其他的类或者接口.
 在密封类中不能声明受保护成员或虚成员，因为受保护成员只能从派生类中访问，而虚成员可以在派生类中重载。
 由于密封类的不可继承性，其不能声明为抽象的，即sealed和abstract修饰符不能同时使用.

```c#
public sealed class myClass //声明的密封类
{
    public int = 0;
    public void method()
    {
        
    }
}
```
这里有一个值得注意的地方,值类型的基类System.ValueType直接派生字System.Object。也许你会奇怪，object不是引用类么？
ValueType作为其子类不是应该也是么。因为C#重载了Equals()方法。使得System.ValueType作为值类型.


怎么判断一个类型是值类型呢？用Type.IsValueType.
```
Type aType = new Type();
if(aType.GetType().IsValueType)
{
    System.Console.WriteLine("这是一个值类型");
}
```

#### 6.2、引用类型
数组 派生自System.Array.

用户自定义的类型:class,interface,delegate,object(System.Object的别名),string

#### 6.3、值类型和引用类型在内存中的部署
MSDN上说:托管堆上部署了所有引用类型.

```
object refernce = new object();
```
new 操作符将在托管对上创建一个内存，并分配其内存地址。reference在栈上保存着这个地址。在次reference相当于C语言中的指针.

##### 6.3.1、数组
```
int[] reference = new int[100];
```
根据前面所说，数组属于引用类型，而int则为数值类型。

那么问题来了!引用类型的数组中保存的值类型元素它到底存放在栈中还是堆中呢？

如果我们用windg查看reference[i]在内存中的具体位置，那么就会发现他们都存储在堆中。

```
Type[] array = new Type[100];
```
如果Type是值类型，则会一次性在托管堆中分配空间，并给其所有元素初始化。

如果Type是引用类型，则会再堆栈中为数组array分配一次空间，但是不会为其元素初始化。只有等到以后有显式初始化这个元素时，
这个引用类型的元素才被分配空间到托管堆上。

##### 6.3.2、嵌套类型
假如引用类型包括了数值类型，那么这个变量存放在什么地方呢？这个变量的成员又存放在什么地方呢？

计入数值类型包括了引用类型，那么这个变量应该存放在什么地方呢？这个变量的各个组成部分又应该放在什么地方呢？

```
public class ReferenceTypeClass
{
    private int _valueTypeFiled; //值类型

    public int Method()
    {
        int localValueType = 0; //值类型
    }
}

ReferenceTypeClass referenceTypeInstance = new ReferenceTypeClass();//不用说，referenceTypeInstance指向的地址存放在堆栈中
//_valueTypeFiled 会存放在什么地方呢？
referenceTypeInstance.Method(); //此时Method方法内的局部变量又存放在什么地方呢？

public struct ValueTypeStruct
{
    private object _referenceField;
    
    public void Method()
    {
        object localReferece = new object();
    }
}

ValueTypeStruct valueTypeInstance = new ValueTypeStruct();
valueTypeInstance.Method();
```

valueTypeInstance 为一个结构体，按照常理应该保存在栈中，那么_referenceField 和localReference引用变量应该存在什么地方呢？
>一般规律:引用类型存放在堆中

数值类型总是更随其上下文。作为某个类成员时，将会更随所属变量。

局部变量，则存在于栈中。

##### 6.3.3、正确使用数值类型和引用类型
下面是从Effective C#摘录的一部分关于引用类型和数值类型的使用场合：
1.如果以下问题都是yes我们应该创建为值类型
>1.该类型主要职责是否用于存储数据？
 2.该类型的公有接口是否完全由一些数据成员存储属性定义?
 3.是否确信该类型永远不可能有子类？
 4.是否确信类型永远不可能具有多态？

2.数值类型尽可能实现具有常量性和原子性
>1.常量性:如果构造的时候验证了参数的有效性，那么后面使用的时候就一直有效。

禁止更改，这样会省去后面很多不必要的错误检查。

确保线程安全，引用多个线程同时访问时都是同样地内容。

 2.具有原子性:我们通常会直接替换一个原子型的整个类容.
 
 下面有一个例子
 

 ```
 public struct Address
 {
    private string _city;
    private string _province;
    private int _zipCode;

    public string City
    {
        get{return _city;}
        set{_city = value;}
    }

    public string Province
    {
        get{return _province;}
        set{_province = value;}
    }
    
    public int ZipCode
    {
        get{return _zipCode;}
        set{_zipCode = value;}
    }
 }

 //创建一个实例
 Address address = new Address();
 address.City = "Chengdu";
 address.Province = "Sichuan";
 address.ZipCode = 61000;
 //更改这个实例
 address.City = "Nanjing";
 address.Province = "Jiangsu";
 ```

 内部状态的改变可能违反对象的不变式.
 如果一个多线程程序，在更改City的过程中，另外一个线程可能得到不一致的数据视图。
 将Address改为常量类型

 ```
 public struct Address
 {
    private string _city;
    private string _province;
    private int    _zipCode;

    public Address(string city,string province,int zipCode)
    {
        _city = city;
        _province = province;
        _zipCode = zipCode;
    }

    public string City
    {
        get{return _city;}
    }

    public string Province
    {
        get{return _province;}
    }

    public int ZipCode
    {
        get{return _zipCode;}
    }
 }
 //如果此时需要更改address，那么就不能修改现有实例了，必须创建一个新的实例
 Address address = new Address("Chengdu","Sichuan",610000);
 address = new Address("Nanjing","Jiangsu",210000);
 ```

 此时Address将不会存在线程安全性问题。
 

##### 6.3.4 确保0为值类型的有效状态
.net 的默认初始化会将应用类型设置为null，而值类型，无论我们是否提供构造函数，都会有一个默认的构造函数，将其设置为0.

##### 6.3.5 尽量减少装箱和拆箱操作
装箱是指一个值类型放入一个未具名类型的引用类型中，如：

```
int valueType = 0;
object refenceType = valueType;
```

拆箱是指从前面的装箱对象中取出值类型:
```
object refenceType;
int valueType = (int)refenceType;
```

装箱和拆箱相当耗费性能，而且很有可能引起一些非常诡异的bug，我们应该尽量避免。而且装箱和拆箱最大的问题在于总会自动进行。

### 7、总结
1.C#中变量是值类型还是引用类型取决于数据类型。
2.C#中的值类型，包括基本的内置类型，结构体，枚举，可空类型。
3.C#中的应用类型，包括数组，类，接口，委托，object,字符串。
4.数组的元素，不管是引用类型还是数值类型都存放在堆中。
5.数值类型在内存管理方面具有更好的效率，但是不支持多态。且用于存储数据。
6.引用类型则适用于定义程序的行为，且支持多态和派生。
7.数值类型尽量满足常量性和原子性。
8.确保数值类型的0为类型的有效状态
9.尽量避免装箱和拆箱操作。

