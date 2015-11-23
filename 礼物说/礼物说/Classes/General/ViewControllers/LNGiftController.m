//
//  LNGiftController.m
//  礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "LNGiftController.h"

@interface LNGiftController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation LNGiftController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"礼物详情";
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_webView];
    
}


- (void)viewWillAppear:(BOOL)animated {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
}

@end
