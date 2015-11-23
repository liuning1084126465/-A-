//
//  LNHotModel.m
//  礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "LNHotModel.h"

@implementation LNHotModel

//- (void)setValue:(id)value forKey:(NSString *)key {
////    if ([key isEqualToString:@"price"]) {
////        return;
////    }
////    if ([value class] == [NSNull class]) {
////        return;
////    }
////    if ([key isEqualToString:@"brand_order"]) {
////        NSLog(@"%@",[value class]);
////    }
////    NSLog(@"%@--%@",key, [value class]);
////    if ([key isEqualToString:@"subcategory_id"]) {
////        if (value == nil) {
////            _subcategory_id = 9999;
////        }
////    }
//    [super setValue:value forKey:key];
//}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        _des = value;
    }
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"%@%@%@", _brand_id, _name, _url];
}

@end
