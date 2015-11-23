//
//  LNHomeListCell.m
//  礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "LNHomeListCell.h"

@interface LNHomeListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *likes_count;

@property (nonatomic, strong) UILabel *lab4title;
@property (nonatomic, strong) UIButton *likes_coun;
@end

@implementation LNHomeListCell


- (void)awakeFromNib {
    // Initialization code
    self.imgView.frame = CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height - 10);
    self.imgView.layer.masksToBounds = YES;
    self.imgView.layer.cornerRadius = 5;
    
    self.lab4title = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.height * 0.9, self.frame.size.width - 60, self.frame.size.height / 4)];
     self.lab4title.textColor = [UIColor whiteColor];
    self.lab4title.numberOfLines = 0;
    self.lab4title.font = [UIFont boldSystemFontOfSize:15];
    

    self.likes_count.backgroundColor = [UIColor grayColor];
    self.likes_count.layer.masksToBounds = YES;
    self.likes_count.layer.cornerRadius = 10;
    [self.likes_count setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
//    [self.imgView addSubview:self.likes_count];
    [self.imgView addSubview:self.lab4title];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHomeModel:(LNHomeModel *)homeModel {
    _homeModel = homeModel;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:homeModel.cover_image_url] placeholderImage:nil];
    [self.likes_count setTitle:[NSString stringWithFormat:@"❤️%@", homeModel.likes_count] forState:UIControlStateNormal];
    self.lab4title.text = _homeModel.title;
    

    
    NSLog(@"self.title.text = %@", self.lab4title.text);
}

// 点赞按钮


@end
