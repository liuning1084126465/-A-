//
//  ClassifyManager.h
//  礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^UpdataBlock)();

@interface ClassifyManager : NSObject
// 分组名称
@property (nonatomic, strong) NSMutableArray *classifyNameArray;
// 存放所有model
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) UpdataBlock updataBlock;
+ (ClassifyManager *)sharedManager;
@end
