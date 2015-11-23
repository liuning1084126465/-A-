//
//  LNDetailController.m
//  礼物说
//
//  Created by lanou3g on 15/11/18.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "LNDetailController.h"
#import "LNNavigationController.h"

@interface LNDetailController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation LNDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"攻略详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<礼物说" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    [self.view addSubview:_webView];
    
    
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
}


@end
