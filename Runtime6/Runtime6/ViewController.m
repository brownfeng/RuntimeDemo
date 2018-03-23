//
//  ViewController.m
//  Runtime6
//
//  Created by pp on 2018/3/22.
//  Copyright © 2018年 webank. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()
{
    NSObject *_property0;
    UIView *_property1;
    UIViewController *_property2;
    float _property3;
    int _property4;
}
@property (nonatomic,strong)NSObject *_property5;
@property (nonatomic,  weak)UIView   *property6;
@property (nonatomic,strong)UIViewController *property7;

@property (nonatomic,assign)float property8;
@property (nonatomic,assign)int property9;
@property (nonatomic,strong,readonly)UIViewController *property10;
@property (nonatomic,readwrite) UIViewController *property11;
@property (nonatomic,  copy)NSString *property12;
@end

@implementation ViewController
//编码值     含意
//c     代表char类型
//i     代表int类型
//s     代表short类型
//l     代表long类型，在64位处理器上也是按照32位处理
//q     代表long long类型
//C     代表unsigned char类型
//I     代表unsigned int类型
//S     代表unsigned short类型
//L     代表unsigned long类型
//Q     代表unsigned long long类型
//f     代表float类型
//d     代表double类型
//B     代表C++中的bool或者C99中的_Bool
//v     代表void类型
//*     代表char *类型
//@     代表对象类型
//#     代表类对象 (Class)
//:     代表方法selector (SEL)
//[array type]     代表array
//{name=type…}     代表结构体
//(name=type…)     代表union
//bnum     A bit field of num bits
//^type     A pointer to type
//?     An unknown type (among other things, this code is used for function pointers)
- (void)viewDidLoad {
    [super viewDidLoad];
    // class 获取 -- 获取整个属性列表(只获取属性不获取变量)
    /*
     1. 获取所有属性
     2. 获取的属性名称和你写的代码一样, 获取出来的属性名称不会自定添加下划线
     */

    unsigned int outCount = 0;
    objc_property_t *props = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i<outCount; i++) {
        objc_property_t property = props[i];
        const char *name = property_getName(property);
        const char *attributes = property_getAttributes(property);

        NSLog(@">>>>>>>>0:%@:%@",
              [NSString stringWithUTF8String:name],
              [NSString stringWithUTF8String:attributes]);
    }

    free(props);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
