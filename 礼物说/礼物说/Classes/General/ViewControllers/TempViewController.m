
//
//  TempViewController.m
//  QRCode_Demo
//
//  Created by 沈红榜 on 15/11/17.
//  Copyright © 2015年 沈红榜. All rights reserved.
//

#import "TempViewController.h"
#import "SHBQRView.h"

@interface TempViewController ()<SHBQRViewDelegate>

@end

@implementation TempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 新建扫描视图控制器
    SHBQRView *qrView = [[SHBQRView alloc] initWithFrame:self.view.bounds];
    qrView.delegate = self;
    [self.view addSubview:qrView];
}

// 扫描结果方法
- (void)qrView:(SHBQRView *)view ScanResult:(NSString *)result {
    [view stopScan];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"扫描结果：%@", result] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // 重新扫描
        [view startScan];
    }]];
    [self presentViewController:alert animated:true completion:nil];
}

@end
