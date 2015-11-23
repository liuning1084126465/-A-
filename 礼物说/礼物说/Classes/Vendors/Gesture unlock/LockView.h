//
//  LockView.h
//
//  Created by 刘 宁 on 15/9/21.
//  Copyright (c) 2015年 刘 宁. All rights reserved.
//


#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, passwordtype){
    ResetPassWordType = 1,
    UsePassWordType = 2,
};
@class LockView;
@protocol LockViewDelegate <NSObject>

- (BOOL)unlockView:(LockView *)unlockView withPassword:(NSString *)password;

- (void)setPassWordSuccess:(NSString *)tabelname;
@end

@interface LockView : UIView
@property (nonatomic, weak) id<LockViewDelegate> delegate;
@end
