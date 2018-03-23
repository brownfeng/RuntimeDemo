//
//  UIButton+Block.m
//  Runtime9
//
//  Created by pp on 2018/3/22.
//  Copyright © 2018年 webank. All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>


/*
 关联对象的左右:

 1> 给既定的类添加一个属性!!!!
 例如:

 如果需要给NSArray添加一个属性:
 1. 我们继承NSArray, 然后在子类添加一个属性
 2. 使用runtime中的关联对象方法, 给某一个对象设置一个关联对象, 这个关联对象就是这个类的一个属性

 具体做法:
 我们可以在category中增加一个property. 然后在setter, getter方法中使用 associated object


 优秀的使用实例:
 1. 添加私有属性用于更好地去实现细节。当扩展一个内建类的行为时，保持附加属性的状态可能非常必要。注意以下说的是一种非常教科书式的关联对象的用例：AFNetworking在 UIImageView 的category上用了关联对象来保持一个operation对象，用于从网络上某URL异步地获取一张图片。

 2. 添加public属性来增强category的功能。有些情况下这种(通过关联对象)让category行为更灵活的做法比在用一个带变量的方法来实现更有意义。在这些情况下，可以用关联对象实现一个一个对外开放的属性。回到上个AFNetworking的例子中的 UIImageViewcategory，它的 imageResponseSerializer方法允许图片通过一个滤镜来显示、或在缓存到硬盘之前改变图片的内容。

 3.创建一个用于KVO的关联观察者。当在一个category的实现中使用KVO时，建议用一个自定义的关联对象而不是该对象本身作观察者。ng an associated observer for KVO**. When using KVO in a category implementation, it is recommended that a custom associated-object be used as an observer, rather than the object observing itself.


 注意:
 1. const void *key 类型通常都是通常都是会采用静态变量来作为关键字
 2. 可以自己创建 也可以使用"@selector(btnAction:)"
 3. 使用的@selector(xxx), 理论是 一个 SEL, 实际底层是一个 const char *
 4. 在一个方法里面. 使用 `_cmd` 直指当前方法名称@selector.

 */
@implementation UIButton (Block)

-(void)handleWithBlock:(btnBlock)block{

    if (block) {
        objc_setAssociatedObject(self, @selector(btnAction:), block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    [self addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btnAction:(id)sender{
    /*
     这里设置的key有3种写法:
     (1)静态变量&btnKey
     (2)@selector(methodName)
     (3)_cmd
    */
    btnBlock block = objc_getAssociatedObject(self, _cmd);
    if (block) {
        block(sender);
    }
}
@end
