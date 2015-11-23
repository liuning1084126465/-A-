//
//  LNLoginControlelr.h
//  礼物说
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LNLoginControlelr;

@protocol LoginDelegate <NSObject>
- (void)transerIsLogin:(BOOL)isLogin andUsername:(NSString *) username;
@end

@interface LNLoginControlelr : UIViewController
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, assign) id <LoginDelegate> delegate;
@end
