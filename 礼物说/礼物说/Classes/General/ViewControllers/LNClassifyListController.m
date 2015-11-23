//
//  LNClassifyListController.m
//  礼物说
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "LNClassifyListController.h"
#import "LNHomeListCell.h"
#import "LNHomeModel.h"
#import "LNDetailController.h"


@interface LNClassifyListController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

static NSString *identifier = @"listView";

@implementation LNClassifyListController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:20];
    }
    return _dataArray;
}

- (void)dataParseWithURL:(NSString *)URLString {
    NSURL *url = [NSURL URLWithString:URLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            //                NSLog(@"%@", dic);
            
            NSDictionary *tempDataDic = dic[@"data"];
            NSArray *itemsArray = tempDataDic[@"items"];
            
            for (NSDictionary *dic in itemsArray) {
                LNHomeModel *homeModel = [LNHomeModel new];
                [homeModel setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:homeModel];
            }
            
            // 返回主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }

    }];
    [dataTask resume];
}

// 添加头部刷新
- (void)headerRereshing
{
    NSString * strPath = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/channels/%ld/items?limit=20&offset=0", self.ID];
    [self dataParseWithURL:strPath];
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}

// 尾部刷新
- (void)footerRereshing
{
    static int a = 0;
    a += 20;
    
    NSString * strPath = [NSString stringWithFormat:@"http://api.liwushuo.com/v2/channels/%ld/items?limit=20&offset=0", self.ID];
    [self dataParseWithURL:strPath];
    
    // 2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleName;
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"LNListViewController"] bundle:[NSBundle mainBundle] forCellReuseIdentifier:identifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"LNHomeListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
    
    // 添加头部刷新
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // 添加尾部刷新
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 自动进入刷新状态
    [self.tableView headerBeginRefreshing];
    [self.tableView footerBeginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LNHomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    // Configure the cell...
    LNHomeModel *homeModel = self.dataArray[indexPath.row];
    cell.homeModel = homeModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LNHomeModel *homeModel = self.dataArray[indexPath.row];
    
    
    LNDetailController *detailVC = [[LNDetailController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:detailVC];
    detailVC.url = homeModel.content_url;
    NSLog(@"----");
    [self presentViewController:nav animated:YES completion:nil ];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
