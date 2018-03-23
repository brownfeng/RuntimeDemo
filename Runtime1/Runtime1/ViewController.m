//
//  ViewController.m
//  Runtime1
//
//  Created by pp on 2018/3/21.
//  Copyright © 2018年 webank. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()
@property (nonatomic,strong)NSArray *property0;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
}
-(void)test{
    const char *class_name = class_getName([self class]);
    NSLog(@">>>>0: %s", class_name);

    Class superClass = class_getSuperclass([self class]);
    NSLog(@">>>>1: %@", NSStringFromClass(superClass));

    Ivar ivar = class_getInstanceVariable([self class], "_property0");
    const char *ivarName = ivar_getName(ivar);
    NSLog(@">>>>2: %@", [NSString stringWithUTF8String:ivarName]);

    const char *typeEnCoding = ivar_getTypeEncoding(ivar);
    NSLog(@">>>>3: %@", [NSString stringWithUTF8String:typeEnCoding]);

    objc_property_t prop = class_getProperty([self class], "property0");
    const char *propName = property_getName(prop);
    NSLog(@">>>>4: %@", [NSString stringWithUTF8String:propName]);
    const char *propAttr = property_getAttributes(prop);
    NSLog(@">>>>5: %@", [NSString stringWithUTF8String:propAttr]);


    Method method = class_getClassMethod([self class], @selector(test2));
    SEL methodName = method_getName(method);
    NSLog(@">>>>6: %@", NSStringFromSelector(methodName));

    Method method2 = class_getInstanceMethod([self class], @selector(test1));
    SEL mothodName2 = method_getName(method2);
    NSLog(@">>>>7: %@", NSStringFromSelector(mothodName2));
    IMP imp2 = method_getImplementation(method2);
    imp2();
}

-(void)test1 {
    NSLog(@"instance method");
}

+(void)test2{
    NSLog(@"class method");
}

@end
