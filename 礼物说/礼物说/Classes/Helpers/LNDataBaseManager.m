//
//  LNDataBaseManager.m
//  选礼物
//
//  Created by lanou3g on 15/11/23.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "LNDataBaseManager.h"

@implementation LNDataBaseManager
+ (FMDatabaseQueue *)shareData {
    // 1.获取数据库路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documentPath stringByAppendingString:@"/user.sqlite"];
    NSLog(@"path = %@", path);
    
    // 2.创建数据库
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 3.打开数据库并创建表格
    [queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"create table if not exists userInfo(username text, password text, email text, telephone text, imgView data);"];
        if (result) {
            NSLog(@"创表成功");
        } else {
            NSLog(@"创表失败");
        }
    }];
    
    return queue;
}
@end
