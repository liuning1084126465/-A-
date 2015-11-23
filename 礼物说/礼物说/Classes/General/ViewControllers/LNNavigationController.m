
//
//  LNNavigationController.m
//  00-ItcastLottery
//
//  Created by lanou3g on 15/10/31.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "LNNavigationController.h"

@interface LNNavigationController ()

@end

@implementation LNNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// 系统在第一次使用这个类的时候会调用(1个类只会调用一次)
+ (void)initialize
{
    // 1.设置导航栏背景图片
    UINavigationBar *navBar = [UINavigationBar appearance];
    if (iOS7) {
        // 更改图片iOS7之后
        [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
        [navBar setTintColor:[UIColor whiteColor]];
    } else {
        // 更改图片
        [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar"] forBarMetrics:UIBarMetricsDefault];
    }

    
    // 2.设置标题栏文字
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [navBar setTitleTextAttributes:attributes];
    
    // 3.设置BarButtonItem的主题
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *attributesTitle = [NSMutableDictionary dictionary];
    attributesTitle[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [item setTitleTextAttributes:attributesTitle forState:UIControlStateNormal];
    
    // 设置按钮背景
    if (!iOS7) {
        [item setBackgroundImage:[UIImage imageNamed:@"NabButton"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageNamed:@"NabButtonPressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        // 设置返回按钮颜色
        [item setBackButtonBackgroundImage:[UIImage imageNamed:@"NabBackButton"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackButtonBackgroundImage:[UIImage imageNamed:@"NabBackButtonPressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

@end
