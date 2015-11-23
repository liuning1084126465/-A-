//
//  ClassifyManager.m
//  礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "ClassifyManager.h"
#import "LNClassifyModel.h"

static ClassifyManager *classifyManager = nil;

@implementation ClassifyManager
+ (ClassifyManager *)sharedManager {
    if (classifyManager == nil) {
        classifyManager = [[ClassifyManager alloc] init];
        [classifyManager dataParse];
    }
    return classifyManager;
}

- (void)dataParse {
    // 开辟子线程，在子线程中访问数据，防止假死
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 1.创建URL
        NSURL *url = [NSURL URLWithString:CLASSIFYURL];
        // 2.创建请求对象
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        // 3.建立会话
        NSURLSession *sesson = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [sesson dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                
                NSDictionary *tempDataDic = dic[@"data"];
                NSArray *channel_groupsArray = tempDataDic[@"channel_groups"];
                
                
                
                for (NSDictionary *dic in channel_groupsArray) {
                    // 把分组名加到一个数组中
                    [self.classifyNameArray addObject:dic[@"name"]];
                    
                    NSArray *channelsArray = dic[@"channels"];
                    
                    NSMutableArray *tempResultArray = [NSMutableArray arrayWithCapacity:20];
                    for (NSDictionary *resultDic in channelsArray) {
                        LNClassifyModel *classifyModel = [LNClassifyModel new];
                        [classifyModel setValuesForKeysWithDictionary:resultDic];
                        [tempResultArray addObject:classifyModel];
                    }
                    [self.dataArray addObject:tempResultArray];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //            [self.collectionView reloadData];
                    NSLog(@"---+++-%ld", self.dataArray.count);
                    self.updataBlock();
                });
            }
        }];
        // 使用resume方法启动任务
        [task resume];
    });
}

// dataArray的懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:20];
    }
    return _dataArray;
}

// classifyNameArray的懒加载
- (NSMutableArray *)classifyNameArray {
    if (!_classifyNameArray) {
        _classifyNameArray = [NSMutableArray arrayWithCapacity:20];
    }
    return _classifyNameArray;
}
@end
