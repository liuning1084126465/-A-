//
//  LNTabBar.h
//  00-ItcastLottery
//
//  Created by lanou3g on 15/10/31.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LNTabBar;

@protocol LNTabBarDelegate <NSObject>
@optional
- (void)tabBar:(LNTabBar *)tabBar didSelectButtonFrom:(int)from to:(int)to;
@end

@interface LNTabBar : UIView
@property (nonatomic, assign) id <LNTabBarDelegate> deletage;


// 用来添加一个内部的按钮
- (void)addTabButtonWithName:(NSString *)name andWithSelectName:(NSString *)selectName;
@end
