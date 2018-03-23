//
//  UIButton+Block.h
//  Runtime9
//
//  Created by pp on 2018/3/22.
//  Copyright © 2018年 webank. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^btnBlock)(id sender);

@interface UIButton (Block)
-(void)handleWithBlock:(btnBlock)block;
@end
