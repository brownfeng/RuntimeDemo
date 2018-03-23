//
//  Person.h
//  Runtime11
//
//  Created by pp on 2018/3/23.
//  Copyright © 2018年 webank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *job;

- (instancetype)initWithNSDictionary:(NSDictionary *)dict;

-(NSDictionary *)toDictionary;
@end
