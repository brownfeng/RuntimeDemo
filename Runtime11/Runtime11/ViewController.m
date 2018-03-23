//
//  ViewController.m
//  Runtime11
//
//  Created by pp on 2018/3/23.
//  Copyright © 2018年 webank. All rights reserved.
//

/*
 json 转 model
 */
#import "ViewController.h"
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self json2Model];
    [self model2Dict];
}


-(void)json2Model{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Persons" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    for (NSDictionary *model in array) {
        Person *person = [[Person alloc] initWithNSDictionary:model];
        NSLog(@"%@, %ld, %@, %@", person.name, (long)person.age, person.city, person.job);
    }
}

-(void)model2Dict{
    Person *person = [[Person alloc] init];
    person.name = @"pp";
    person.age = 100;
    person.city = @"sz";
    person.job = @"it";
    NSDictionary *dict = [person toDictionary];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"key: %@, obj: %@, objCls: %@ \n", key, obj, NSStringFromClass([obj class]));
    }];
    NSLog(@"%@", dict);
}


@end
