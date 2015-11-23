//
//  LNTabBar.m
//  00-ItcastLottery
//
//  Created by lanou3g on 15/10/31.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "LNTabBar.h"
#import "LNTabBarButton.h"

@interface LNTabBar ()
@property (nonatomic, weak) UIButton *selectButton;
@end

@implementation LNTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)addTabButtonWithName:(NSString *)name andWithSelectName:(NSString *)selectName {
    // 创建按钮
    LNTabBarButton *button = [LNTabBarButton buttonWithType:UIButtonTypeCustom];
    // 设置普通状态下显示的图片
    [button setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    // 设置选中状态下的图片
    [button setBackgroundImage:[UIImage imageNamed:selectName] forState:UIControlStateSelected];
    
    
    
    // 添加
    [self addSubview:button];
    
#warning UIControlEventTouchDown:手指按下去就会响应时间
    // 添加监听
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
}


- (void)layoutSubviews {
    for (int i = 0; i < self.subviews.count; i++) {

        
        LNTabBarButton *button = self.subviews[i];
        
        // 按钮的tag
        button.tag = i;
        
        // 设置位置
        button.frame = CGRectMake(i * self.frame.size.width / self.subviews.count, 0, self.frame.size.width / self.subviews.count, self.frame.size.height);
        
        // 设置默认选中第一个
        if (i == 0) {
            [self buttonClick:button];
        }
    }
}

- (void)buttonClick:(LNTabBarButton *)sender {
    
    // 4.通知代理执行方法
    //    self.selectedIndex = sender.tag;
    if ([self.deletage respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]) {
        [_deletage tabBar:self didSelectButtonFrom:self.selectButton.tag to:sender.tag];
    }
    
    
    // 1.把原来的按钮选中状态置为NO
    self.selectButton.selected = NO;
    // 2.把新的按钮选中状态置为YES
    sender.selected = YES;
    // 3.把新点击的按钮置为当前的按钮
    self.selectButton = sender;
    

}

@end
