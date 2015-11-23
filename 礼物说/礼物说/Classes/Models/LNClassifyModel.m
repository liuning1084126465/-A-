//
//  LNClassifyModel.m
//  礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "LNClassifyModel.h"

@implementation LNClassifyModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _ID = [value integerValue];
    }
}
@end
