//
//  ViewController.m
//  Runtime9
//
//  Created by pp on 2018/3/22.
//  Copyright © 2018年 webank. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+Extension.h"
#import <objc/runtime.h>

@interface ViewController ()
@property (nonatomic, strong) NSString *tmpStr;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@end

@implementation ViewController

// 关联对象学习
/*
 相当于 setValue:forKey 进行关联value对象
 void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);

 用来读取对象 - 获取关联对象
 id objc_getAssociatedObject(id object, const void *key);

 objc_AssociationPolicy  属性 是设定该value在object内的属性，即 assgin, (retain,nonatomic)...等


 用来移除关联对象
 void objc_removeAssociatedObjects(id object);

 key：要保证全局唯一，key与关联的对象是一一对应关系。必须全局唯一。通常用@selector(methodName)作为key。
 value：要关联的对象。
 policy：关联策略。有五种关联策略。
 OBJC_ASSOCIATION_ASSIGN 等价于 @property(assign)。
 OBJC_ASSOCIATION_RETAIN_NONATOMIC等价于 @property(strong, nonatomic)。
 OBJC_ASSOCIATION_COPY_NONATOMIC等价于@property(copy, nonatomic)。
 OBJC_ASSOCIATION_RETAIN等价于@property(strong,atomic)。
 OBJC_ASSOCIATION_COPY等价于@property(copy, atomic)。
 */


-(void)viewDidLoad{
    [super viewDidLoad];
    [self test];
}
/*

 注意:
 category与associative作为objective-c的扩展机制的两个特性，category即类型，可以通过它来扩展方法；associative，可以通过它来扩展属性

 可以结合这两个工具对一个既有的类通过category 添加属性. 并且这个属性可以通过kvo进行监听

 在ObjC中要实现KVO则必须实现NSKeyValueObServing协议， NSObject已经实现了该协议，因此几乎所有的ObjC对象都可以使用KVO

 这个实例说明. 通过category + runtime AssociatedObj实现的属性, 可以使用 KVO监听
 */
-(void)test{
    self.tmpStr = @"测试使用";
    self.categoryString = @"Runtime生成的属性";
    [self addObserver:self forKeyPath:@"categoryString" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"<接收到通知: object:%@ keyPath:%@ change:%@>", object, keyPath,change);

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.categoryString = self.textFiled.text;
    NSLog(@"---self.tmp2Str-->%@<-----",self.categoryString);

}

@end
