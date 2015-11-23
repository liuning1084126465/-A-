//
//  LNHotController.m
//  礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "LNHotController.h"
#import "ImageCell.h"
#import "LNHotModel.h"
#import "HotManager.h"
#import "LNGiftController.h"

@interface LNHotController ()
@property (nonatomic, strong) HotManager *hotManager;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation LNHotController

static NSString * const reuseIdentifier = @"Cell";

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _dataArray;
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
//                    self.updataBlock();
                    [self.collectionView reloadData];
                });
            }
        }];
        // 使用resume方法启动任务
        [task resume];
        //        }
        
    });
}


// 添加头部刷新
- (void)headerRereshing
{
    NSString * strPath = [NSString stringWithFormat:@"%@0", HOTURL];
    self.hotManager = [HotManager sharedManagerWithURLString:strPath];
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
//        [self.collectionView reloadData];
        [HotManager sharedManagerWithURLString:strPath].updataBlock = ^(){
            [self.collectionView reloadData];
        };
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.collectionView headerEndRefreshing];
    });
}

// 尾部刷新
- (void)footerRereshing
{
    static int a = 0;
    a += 20;
    
    NSString * strPath = [NSString stringWithFormat:@"%@%d", HOTURL, a];
    self.hotManager = [HotManager sharedManagerWithURLString:strPath];
    
    // 2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [HotManager sharedManagerWithURLString:strPath].updataBlock = ^(){
            [self.collectionView reloadData];
        };
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.collectionView footerEndRefreshing];
    });
}


- (HotManager *)hotManager {
    static int a = 0;
    _hotManager = [HotManager sharedManagerWithURLString:[NSString stringWithFormat:@"%@%d", HOTURL, a]];
    a += 20;

    return _hotManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    // 创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置item
    layout.itemSize = CGSizeMake(self.view.frame.size.width / 2 - 20, self.view.frame.size.width / 2 + 50);
    // UICollectionView
    // 创建collectionView之前，必须先创建描述对象
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
//    [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    // Do any additional setup after loading the view.
    
    __block typeof(self) temp = self;
    self.hotManager.updataBlock = ^(){
        [temp.collectionView reloadData];
    };

    // 添加头部刷新
    [self.collectionView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // 添加尾部刷新
    [self.collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 自动进入刷新状态
    [self.collectionView headerBeginRefreshing];
    [self.collectionView footerBeginRefreshing];
   
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.hotManager.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    // Configure the cell
    if (self.hotManager.dataArray.count) {
        LNHotModel *hotModel = self.hotManager.dataArray[indexPath.row];
        cell.hotModel = hotModel;
    }
    
    return cell;
}

// 设置item内边距大小(上左下右) 和layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5); 一样，但是用属性设置太过于局限
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LNHotModel *hotModel = self.hotManager.dataArray[indexPath.row];
    
    LNGiftController *giftVC = [[LNGiftController alloc] init];
    giftVC.url = hotModel.purchase_url;
    [self.navigationController pushViewController:giftVC animated:YES];
}


@end
