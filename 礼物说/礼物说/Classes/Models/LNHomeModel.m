//
//  LNHomeModel.m
//  礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "LNHomeModel.h"

@implementation LNHomeModel
- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
//    NSLog(@"%@--%@", key, [value class]);
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
    if ([key isEqualToString:@"template"]) {
        _temp = value;
    }
}
@end
