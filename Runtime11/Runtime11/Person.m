//
//  Person.m
//  Runtime11
//
//  Created by pp on 2018/3/23.
//  Copyright © 2018年 webank. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

-(instancetype)initWithNSDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self processDict:dict];
    }
    return self;
}

-(void)processDict:(NSDictionary *)dict{
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    unsigned int count = 0;
    objc_property_t *props = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t prop = props[i];
        const char *propCStr = property_getName(prop);
        NSString *propName = [NSString stringWithCString:propCStr encoding:NSUTF8StringEncoding];
        [keys addObject:propName];
    }
    free(props);
    for (NSString *key in keys) {
        if ([dict valueForKey:key]) {
            [self setValue:[dict valueForKey:key] forKey:key];
        }
    }
}


-(NSDictionary *)toDictionary{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    Class cls = [self class];
    while (cls != [NSObject class]) {
        unsigned int count = 0;
        objc_property_t *props = class_copyPropertyList(cls, &count);
        for (int i = 0; i < count; i++) {
            objc_property_t prop = props[i];
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
            if ([propName length] == 0) {
                continue;
            }
            id value = [self valueForKey:propName];
            if (value) {
                [parameters setValue:value forKey:propName];
                if (![NSJSONSerialization isValidJSONObject:parameters]) {
                    [parameters removeObjectForKey:propName];
                }
            }
        }
        if (props) {
            free(props);
        }
        cls = class_getSuperclass(cls);
    }
    return [parameters copy];
}
@end
