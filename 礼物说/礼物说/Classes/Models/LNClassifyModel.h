//
//  LNClassifyModel.h
//  礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNClassifyModel : NSObject
// 分组名
@property (nonatomic, strong) NSString *classifyName;

// model中属性
@property (nonatomic, assign) NSInteger group_id;
@property (nonatomic, strong) NSString *icon_url;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger items_count;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger order;
@property (nonatomic, assign) NSInteger status;
@end
