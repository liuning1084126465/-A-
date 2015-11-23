//
//  LNHomeModel.h
//  礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNHomeModel : NSObject

@property (nonatomic, strong) NSString *cover_image_url;
@property (nonatomic, strong) NSNumber *ID; // 系统关键字id
@property (nonatomic, strong) NSNumber *published_at;
@property (nonatomic, strong) NSString *temp; // 系统关键字template
@property (nonatomic, strong) NSNumber *editor_id;
@property (nonatomic, strong) NSNumber *created_at;
@property (nonatomic, strong) NSString *content_url;
@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *type; // 是NSTaggedPointerString类型
@property (nonatomic, strong) NSString *share_msg;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *updated_at;
@property (nonatomic, strong) NSString *short_title;
@property (nonatomic, assign) BOOL liked;
@property (nonatomic, strong) NSNumber *likes_count;
@property (nonatomic, strong) NSNumber *status;

@end
