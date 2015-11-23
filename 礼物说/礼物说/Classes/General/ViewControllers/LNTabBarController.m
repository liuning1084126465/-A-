//
//  LNTabBarController.m
//  00-ItcastLottery
//
//  Created by lanou3g on 15/10/31.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "LNTabBarController.h"
#import "LNTabBar.h"
#import "LNTabBarButton.h"


@interface LNTabBarController () <LNTabBarDelegate>

@end

@implementation LNTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.由于tabbar是只读的，所以不能直接用setter方法，先移除系统自带的tabbar
//    [self.tabBar removeFromSuperview];
    
    // 2.添加自己的tabbar
    LNTabBar *myTabBar = [[LNTabBar alloc] init];
    myTabBar.deletage = self;
    myTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:myTabBar];
    
    // 3.添加对应个数的按钮
    for (int i = 0; i < self.viewControllers.count; i++) {
        [myTabBar addTabButtonWithName:[NSString stringWithFormat:@"Tab%d", i + 1] andWithSelectName:[NSString stringWithFormat:@"Tab%dSel", i + 1]];
    }

}



#pragma mark LNTabBar的代理方法
- (void)tabBar:(LNTabBar *)tabBar didSelectButtonFrom:(int)from to:(int)to {
    self.selectedIndex = to;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
