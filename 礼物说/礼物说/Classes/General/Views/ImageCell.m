//
//  ImageCell.m
//  礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *loveCount;
@end

@implementation ImageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setHotModel:(LNHotModel *)hotModel {
    _hotModel = hotModel;
    NSLog(@"%@", hotModel);
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:hotModel.cover_image_url] placeholderImage:nil];
    self.name.text = hotModel.name;
    self.price.text = [NSString stringWithFormat:@"￥%@", hotModel.price];
    self.loveCount.text = [NSString stringWithFormat:@"❤️%@", hotModel.favorites_count];
    
    NSLog(@"hotModel.price%@  hotModel.favorites_count%@", hotModel.price, hotModel.favorites_count);
}

@end
