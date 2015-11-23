//
//  LNListViewController.m
//  礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "LNListViewController.h"
#import "LNHomeListCell.h"
#import "LNHomeModel.h"
#import "LNDetailController.h"


@interface LNListViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIScrollView *scrollImage;
@property (nonatomic, strong) UIPageControl *page;
@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, retain) NSTimer *timer;
@end

static NSString *identifier = @"cell";

@implementation LNListViewController

- (NSMutableArray *)imgArray {
    if (!_imgArray) {
        _imgArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _imgArray;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:20];
    }
    return _dataArray;
}

// 解析滚动视图中的滑动图片
- (void)dataParse {
    // 开辟子线程，在子线程中访问数据，防止假死
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 1.创建URL
        NSURL *url = [NSURL URLWithString:@"http://api.liwushuo.com/v2/banners?channel=iOS"];
        // 2.创建请求对象
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        // 3.建立会话
        NSURLSession *sesson = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [sesson dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                NSDictionary *tempDataDic = dic[@"data"];
                NSArray *itemsArray = tempDataDic[@"banners"];
                
                for (NSDictionary *dic in itemsArray) {
//                    LNHomeModel *homeModel = [LNHomeModel new];
//                    [homeModel setValuesForKeysWithDictionary:dic];
//                    [self.dataArray addObject:homeModel];
                    NSString *imgURL = dic[@"image_url"];
                    [self.imgArray addObject:imgURL];
                }
                 NSLog(@"%ld", self.imgArray.count);
                
                // 返回主线程刷新
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self loadHeaderImageView];
                });
                
            }
            
        }];
        // 使用resume方法启动任务
        [task resume];
    });
}

- (void)loadHeaderImageView {
    self.tableView.tableHeaderView.userInteractionEnabled = YES;
    // 1.设置头视图,一般都把轮播图放在这里
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 4)];
    // 2.头视图里面加上ScrollView
    _scrollImage = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 4)];
    _scrollImage.contentSize = CGSizeMake(self.view.frame.size.width * self.imgArray.count, self.view.frame.size.height / 4);
    _scrollImage.pagingEnabled = YES;
    // 3.每一个小的视图上面加上图片
    for (int i = 0; i < self.imgArray.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + self.view.frame.size.width * i, 0, self.view.frame.size.width, self.view.frame.size.height / 4)];
        UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tempBtn.frame = imgView.bounds;
        [tempBtn addTarget:self action:@selector(imgClick:) forControlEvents:UIControlEventTouchUpInside];
        imgView.userInteractionEnabled = YES;
        // 添加轻拍手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick:)];
        [imgView addGestureRecognizer:tap];
        [imgView sd_setImageWithURL:self.imgArray[i] placeholderImage:nil];
        [_scrollImage addSubview:imgView];
    }
    // 把scrollImage加到头视图中
    [headView addSubview:_scrollImage];
    // 设置头视图
    self.tableView.tableHeaderView = headView;
    
#pragma mark 设置头视图中UIPageControl
    _page = [[UIPageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 50, self.view.frame.size.height / 4 - 20, 100, 15)];
    _page.numberOfPages = self.imgArray.count;
    _page.currentPageIndicatorTintColor = [UIColor redColor];
    _page.pageIndicatorTintColor = [UIColor grayColor];
    [headView addSubview:_page];
    
#pragma mark 时间设置
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerClick:) userInfo:nil repeats:YES];
}

#pragma mark 时间设置方法
- (void)timerClick:(NSTimer *)sender {
    //当前第几张
    
    NSInteger page = self.page.currentPage;
    
    if (page == self.page.numberOfPages-1) {
        page = 0;
    } else {
        page++;

    }
    
    //同时设置pageControl
    self.page.currentPage = page;
    
    [UIView animateWithDuration:3 animations:^{
        self.scrollImage.contentOffset=CGPointMake(page*self.scrollImage.frame.size.width, 0);
    }];
    
    // 休眠2秒
    sleep(2);
}

/*
 * 轻拍手势方法
 **/
- (void)imgClick:(UITapGestureRecognizer *)sender {
    NSLog(@"轻拍");
}

// 解析列表数据
- (void)dataParseWithURL:(NSString *)URLString {
    // 开辟子线程，在子线程中访问数据，防止假死
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 1.创建URL
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
        // 使用resume方法启动任务
        [task resume];
    });
}

// 添加头部刷新
- (void)headerRereshing
{
    NSString * strPath = [NSString stringWithFormat:@"%@%d", self.url, 0];
    [self dataParseWithURL:strPath];
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 如果连接拼接字符串是间隔是20，就这样拼接
    static int a = 0;
    a+=20;
    
    NSString * strPath = [NSString stringWithFormat:@"%@%d", self.url, 0];
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
    // 设置分割线
    self.tableView.separatorColor = [UIColor clearColor]; // 设置无颜色
    
    
    
    
    
//    [self.tableView registerClass:[LNHomeListCell class] forCellReuseIdentifier:identifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"LNHomeListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
    
    if ([self.url isEqualToString:@"http://api.liwushuo.com/v2/channels/100/items?ad=2&gender=1&generation=1&limit=20&offset="]) {
        NSLog(@"===self.url = %@", self.url);
        // 调用解析透视图方法
        [self dataParse];
    }
    
    // 添加头部刷新
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    // 添加尾部刷新
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 5.自动进入刷新状态
    [self.tableView headerBeginRefreshing];
    [self.tableView footerBeginRefreshing];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LNHomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
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
    [self presentViewController:nav animated:YES completion:nil];
}


@end
