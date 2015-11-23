//
//  LNDataBaseManager.h
//  选礼物
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNDataBaseManager : NSObject
+ (FMDatabaseQueue *)shareData;
@end
