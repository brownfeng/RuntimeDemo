//
//  ViewController.m
//  Runtime3
//
//  Created by pp on 2018/3/21.
//  Copyright © 2018年 webank. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)test {
    Class MyClass = objc_allocateClassPair([NSObject class], "MyClass", 0);
    class_addIvar(MyClass, "name", sizeof(NSString *), <#uint8_t alignment#>, <#const char * _Nullable types#>)
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
