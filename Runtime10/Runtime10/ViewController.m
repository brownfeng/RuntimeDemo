//
//  ViewController.m
//  Runtime10
//
//  Created by pp on 2018/3/22.
//  Copyright © 2018年 webank. All rights reserved.
//

/*
 iOS 方法交换 - method swi
 */
#import "ViewController.h"
#import <objc/runtime.h>


@interface ViewController ()

@end

@implementation ViewController

+(void)load{
    NSString *className = NSStringFromClass(self.class);
    NSLog(@"classname %@", className);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //要特别注意你替换的方法到底是哪个性质的方法
        // When swizzling a Instance method, use the following:
        //        Class class = [self class];

        // When swizzling a class method, use the following:
        Class class = object_getClass((id)self);

        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(xxx_viewWillAppear:);

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));

        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Method Swizzling

/*
我们通过method swizzling修改了UIViewController的@selector(viewWillAppear:)对应的函数指针,使其实现指向了我们自定义的xxx_viewWillAppear的实现。这样，当UIViewController及其子类的对象调用viewWillAppear时，都会打印一条日志信息。
 */
- (void)xxx_viewWillAppear:(BOOL)animated {
    // 由于 系统在调用viewWillAppear时候 会调用到这里. 然后.调用这个以后. 继续调用xxx_viewWillAppear方法, 实际是调用系统的 viewWillAppear方法(因为两个交换过)
    [self xxx_viewWillAppear:animated];
    NSLog(@"viewWillAppear: %@", self);
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


@end
