//
//  HotManager.m
//  礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "HotManager.h"
#import "LNHotModel.h"

static HotManager *hotManager = nil;
@implementation HotManager

+ (HotManager *)sharedManagerWithURLString:(NSString *)URLString {
    if (hotManager == nil) {
        hotManager = [[HotManager alloc] init];
        [hotManager dataParseWithURLString:URLString];
    }
    return hotManager;
}

- (void)dataParseWithURLString:(NSString *)URLString {
    // 开辟子线程，在子线程中访问数据，防止假死
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 1.创建URL
//        for (int i = 0; i <= 2900; i += 50) {
            NSURL *url = [NSURL URLWithString:URLString];
            // 2.创建请求对象
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            // 3.建立会话
            NSURLSession *sesson = [NSURLSession sharedSession];
            NSURLSessionDataTask *task = [sesson dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (data) {
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    
                    
                    NSDictionary *tempDataDic = dic[@"data"];
                    NSArray *itemsArray = tempDataDic[@"items"];
                    
                    
                    
                    for (NSDictionary *tempDic in itemsArray) {
                        NSDictionary *resultDic = tempDic[@"data"];
                        LNHotModel *hotModel = [LNHotModel new];
                        [hotModel setValuesForKeysWithDictionary:resultDic];
                        
                        [self.dataArray addObject:hotModel];
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
//        }
        
    });
}

// dataArray的懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:20];
    }
    return _dataArray;
}
@end
