//
//  ClassifyCell.m
//  礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "ClassifyCell.h"

@interface ClassifyCell ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation ClassifyCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 0.7)];
        self.imgView.layer.masksToBounds = YES;
        self.imgView.layer.cornerRadius = self.frame.size.width / 2;
        self.imgView.backgroundColor = [UIColor orangeColor];
        [self addSubview:_imgView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height * 0.7, self.frame.size.width, self.frame.size.height * 0.3)];
        self.nameLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:_nameLabel];
    }
    return self;
}

- (void)setClassifyModel:(LNClassifyModel *)classifyModel {
    _classifyModel = classifyModel;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:classifyModel.icon_url] placeholderImage:nil];
    self.nameLabel.text = classifyModel.name;
}

@end
