//
//  ViewController.m
//  Runtime8
//
//  Created by pp on 2018/3/22.
//  Copyright © 2018年 webank. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 获取方法名称
    // 入参: 方法名称 SEL
    // 返回: 方法名称 char*

    const char *result0 = sel_getName(@selector(method0));
    NSLog(@">>>>>>>>0:%s",result0);

    // 获取方法id
    // 入参: 属性方法名称 char
    // 返回: SEL
    SEL result1 = sel_getUid(result0);
    NSLog(@">>>>>>>>1:%@",NSStringFromSelector(result1));

    // 获取方法id
    // 入参: 方法名称 char
    // 返回: SEL
    // 在系统中注册一个方法，将方法名映射到一个选择器，并返回这个选择器
    SEL result2 = sel_registerName("method1");
    NSLog(@">>>>>>>>2:%@",NSStringFromSelector(result2));

    //对比方法选择器
    //入参:要对比的两个选择器SEL
    //返回:是否相等
    BOOL result3 = sel_isEqual(result1, result2);
    NSLog(@">>>>>>>>2:%d",result3);

}


-(void)method0{}



@end
