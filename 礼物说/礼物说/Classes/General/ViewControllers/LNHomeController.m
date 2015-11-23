//
//  LNHomeController.m
//  礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "LNHomeController.h"
#import "TempViewController.h"
#import "LNSearchController.h"
#import "LNNavigationController.h"

@interface LNHomeController () <SUNSlideSwitchViewDelegate>

@end

@implementation LNHomeController

- (IBAction)searchAction:(id)sender {
    LNSearchController *searchVC = [LNSearchController new];
    LNNavigationController *nav = [[LNNavigationController alloc] initWithRootViewController:searchVC];
    [self presentViewController:nav animated:YES completion:nil];
}


// 扫描二维码方法
- (void)scan {
    TempViewController *tempVC = [TempViewController new];
    [self.navigationController pushViewController:tempVC animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 左边扫描二维码
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"扫一扫" style:UIBarButtonItemStylePlain target:self action:@selector(scan)];
    
    // 1.初始化滑动视图控件
    self.slideSwitchView = [[SUNSlideSwitchView alloc] initWithFrame:self.view.frame];
    // 2.给滑动视图设置代理，记住本视图控制器要遵循代理
    _slideSwitchView.slideSwitchViewDelegate = self;
    // 3.添加到视图上
    [self.view addSubview:self.slideSwitchView];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // 设置默认状态下的颜色
    self.slideSwitchView.tabItemNormalColor = [SUNSlideSwitchView colorFromHexRGB:@"868686"];
    // 设置选中的状态下的颜色
    self.slideSwitchView.tabItemSelectedColor = [SUNSlideSwitchView colorFromHexRGB:@"bb0b15"];
    // 设置选中阴影的背景图片
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
    // 创建7个控制器
    self.vc1 = [[LNListViewController alloc] init];
    self.vc1.title = @"精选";
    self.vc1.url = @"http://api.liwushuo.com/v2/channels/100/items?ad=2&gender=1&generation=1&limit=20&offset=";
    
    self.vc2 = [[LNListViewController alloc] init];
    self.vc2.title = @"礼物";
    self.vc2.url = @"http://api.liwushuo.com/v2/channels/111/items?gender=1&generation=1&limit=20&offset=";
    
    self.vc3 = [[LNListViewController alloc] init];
    self.vc3.title = @"海淘";
    self.vc3.url = @"http://api.liwushuo.com/v2/channels/129/items?gender=1&generation=1&limit=20&offset=";
    
    self.vc4 = [[LNListViewController alloc] init];
    self.vc4.title = @"美食";
    self.vc4.url = @"http://api.liwushuo.com/v2/channels/118/items?gender=1&generation=1&limit=20&offset=";
    
    self.vc5 = [[LNListViewController alloc] init];
    self.vc5.title = @"涨姿势";
    self.vc5.url = @"http://api.liwushuo.com/v2/channels/120/items?gender=1&generation=1&limit=20&offset=";
    
    self.vc6 = [[LNListViewController alloc] init];
    self.vc6.title = @"数码";
    self.vc6.url = @"http://api.liwushuo.com/v2/channels/121/items?gender=1&generation=0&limit=20&offset=";
    
    self.vc7 = [[LNListViewController alloc] init];
    self.vc7.title = @"运动";
    self.vc7.url = @"http://api.liwushuo.com/v2/channels/123/items?gender=1&generation=0&limit=20&offset=";
    
    // 设置右边按钮
    UIButton *rightSideButton = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置右边按钮箭头
    [rightSideButton setImage:[UIImage imageNamed:@"icon_rightarrow.png"] forState:UIControlStateNormal];
    // 设置右边按钮的尺寸
    rightSideButton.frame = CGRectMake(0, 0, 20.0f, 44.0f);
    // 右边的button等于刚刚设定的button
    self.slideSwitchView.rigthSideButton = rightSideButton;
    
    // 调用更新UI的方法
    [self.slideSwitchView buildUI];
}

#pragma mark -delegate
// 设定一共有几个视图控制器
- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    return 7;
}

// 滑动视图切换视图控制器
- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    if (number == 0) {
        return self.vc1;
    } else if (number == 1) {
        return self.vc2;
    } else if (number == 2) {
        return self.vc3;
    } else if (number == 3) {
        return self.vc4;
    } else if (number == 4) {
        return self.vc5;
    } else if (number == 5) {
        return self.vc6;
    } else if (number == 6) {
        return self.vc7;
    } else {
        return nil;
    }
}

//- (void)slideSwitchView:(SUNSlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer *)panParam
//{
//    ViewController *drawerController = (ViewController *)self.navigationController.mm_drawerController;
//    [drawerController panGestureCallback:panParam];
//}

// 设定选中按钮的时候跳转, 但是感觉并没有什么用
- (void)slideSwitchView:(SUNSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    LNListViewController *vc = nil;
    if (number == 0) {
        vc = self.vc1;
    } else if (number == 1) {
        vc = self.vc2;
    } else if (number == 2) {
        vc = self.vc3;
    } else if (number == 3) {
        vc = self.vc4;
    } else if (number == 4) {
        vc = self.vc5;
    } else if (number == 5) {
        vc = self.vc6;
    } else if (number == 6) {
        vc = self.vc7;
    }
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
