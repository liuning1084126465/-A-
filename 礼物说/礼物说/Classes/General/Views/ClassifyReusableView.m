//
//  ClassifyReusableView.m
//  礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "ClassifyReusableView.h"

@implementation ClassifyReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        [self addSubview:_titleLabel];
    }
    return self;
}
@end
