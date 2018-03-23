//
//  ViewController.m
//  Runtime4
//
//  Created by pp on 2018/3/22.
//  Copyright © 2018年 webank. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>

@interface ViewController ()<UITableViewDelegate>

@end

@implementation ViewController

/*
 方法交换有3种方法:

 1. 使用 class_replaceMethod
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self method0];

    // 1. 通过 class_replaceMethod 交换方法

    /*
     修改SEL对应的IMP: SEL <-> IMP
    */
    BOOL result0 = class_replaceMethod([self class], @selector(method0), (IMP)method1, NULL);
    NSLog(@">>>>>>>>2: %@", @(result0));
    [self method0];
    NSLog(@"\n");

    BOOL result1 = class_conformsToProtocol([self class], NSProtocolFromString(@"UITableViewDelegate"));
    BOOL result2 = class_conformsToProtocol([self class], NSProtocolFromString(@"UITableViewDataSource"));
    BOOL result3 = class_addProtocol([self class], NSProtocolFromString(@"UITableViewDataSource"));
    NSLog(@">>>>>>>>3:%@",@(result1));
    NSLog(@">>>>>>>>4:%@",@(result2));
    NSLog(@">>>>>>>>5:%@",@(result3));

    BOOL result4 = class_conformsToProtocol([self class], NSProtocolFromString(@"UITableViewDelegate"));
    BOOL result5 = class_conformsToProtocol([self class], NSProtocolFromString(@"UITableViewDataSource"));

    NSLog(@">>>>>>>>6:%@",@(result4));
    NSLog(@">>>>>>>>7:%@",@(result5));
    NSLog(@"\n");

    BOOL result6 = class_isMetaClass([self class]);
    NSLog(@">>>>>>>>8:%@",@(result6));

    BOOL result7 = class_respondsToSelector([self class], @selector(method0));
    NSLog(@">>>>>>>>9:%@",@(result7));

    // 此时 SEL 对应的IMP
    BOOL result8 = class_respondsToSelector([self class], @selector(method1));
    NSLog(@">>>>>>>>10:%@",@(result8));
    [ViewController method1];
    
}


-(void)method0{
    NSLog(@">>>>>>>>0");

}
void method1(){
    NSLog(@">>>>>>>>1");
}
+(void)method1{
    NSLog(@">>>>>>>>0");

}

@end
