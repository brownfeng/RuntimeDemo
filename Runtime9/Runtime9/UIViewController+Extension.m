//
//  UIViewController+Extension.m
//  Runtime9
//
//  Created by pp on 2018/3/22.
//  Copyright © 2018年 webank. All rights reserved.
//

#import "UIViewController+Extension.h"
#import <objc/runtime.h>

@implementation UIViewController (Extension)
-(NSString *)categoryString{
    return objc_getAssociatedObject(self, @selector(categoryString));
}


-(void)setCategoryString:(NSString *)categoryString{
    objc_setAssociatedObject(self, @selector(categoryString), categoryString, OBJC_ASSOCIATION_COPY);
}

@end
