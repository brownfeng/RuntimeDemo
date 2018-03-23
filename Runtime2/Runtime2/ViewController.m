//
//  ViewController.m
//  Runtime2
//
//  Created by pp on 2018/3/21.
//  Copyright © 2018年 webank. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import "ViewController+TFExtension.h"
@interface ViewController ()<UITableViewDataSource>
{
    NSArray *_property0;
    NSArray *property1;
}
@property (nonatomic,strong)UIColor *property2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];

}
-(void)test{
    // class 获取整个成员变量的列表
    /**
     *  1.获取所有私有变量和属性
     *  2.获取的私有变量的名和定义的名一模一样
     *  3.获取的属性的名前面都添加了下划线
     */
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSLog(@"ivar: %@", [NSString stringWithUTF8String:name]);
    }
    free(ivars);// class_copyIvarList 方法提示.在获取指针以后需要free这个指针
    NSLog(@"\n");

    //class获取--获取整个属性列表(只获取属性不获取变量)
    /**
     *  1.获取所有属性
     *  2.获取的属性名和你代码写的一样,获取出来的属性名不自动添加下划线
     */
    objc_property_t *props = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t prop = props[i];
        const char *propName = property_getName(prop);
        NSLog(@"prop: %@", [NSString stringWithUTF8String:propName]);
    }
    free(props);
    NSLog(@"\n");

    //class获取--获取整个类的实例方法的方法列表
    /**
     *  1.获取所有实例方法,不包含静态方法
     *  2.不获取父类的方法
     *  3.隐式的get set 方法也能获取到
     *  4.关于Method的更多用法参考Class2类
     */

    Method *methods = class_copyMethodList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methods[i];
        SEL methodSEL = method_getName(method);
        //        NSLog(@"%@", [NSString stringWithUTF8String:methodName]);
        NSLog(@"method: %@", NSStringFromSelector(methodSEL));
    }
    free(methods);
    NSLog(@"\n");

    //添加--协议
    /**
     * 1.class_addProtocol  参数含义:第一个:要添加协议的类,第二个:协议对象
     * 2.获取协议列表具体细节参照Class1里的内容
     */
    Protocol * __unsafe_unretained * protocals = class_copyProtocolList([self class], &outCount);
    for (int i = 0; i< outCount; i++) {
        Protocol *protocal = protocals[i];
        const char *protocalName = protocol_getName(protocal);
        NSLog(@"protocol: %@", [NSString stringWithUTF8String:protocalName]);
    }
    free(protocals);
    NSLog(@"\n");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{return 0;}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{return nil;}

@end
