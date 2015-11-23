//
//  LNLoginControlelr.m
//  礼物说
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "LNLoginControlelr.h"
#import "RigisterViewController.h"
#import "LNDataBaseManager.h"

@interface LNLoginControlelr ()
@property (nonatomic, retain) UITextField *userOrPswTextField;
// 用于存放屏幕宽度和屏幕高度
@property (nonatomic, assign) float wide;
@property (nonatomic, assign) float height;
@end

@implementation LNLoginControlelr

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    // 获取屏幕宽度和屏幕高度
    self.wide = self.view.frame.size.width;
    self.height = self.view.frame.size.height;
    
    self.title = @"登录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(rigist)];
    
    [self addCustomView];
    
}

- (void)addCustomView {
    
    NSArray *labelArray = @[@"用户名", @"密码"];
    NSArray *placeHolderArray = @[@"请输入用户名", @"请输入密码"];
    for (int i = 0; i < 2; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_wide / 9.37, _height / 11.12 + _height / 11.12 * i, _wide / 4.69, _height / 18)];
        label.text = labelArray[i];
        label.font = [UIFont systemFontOfSize:18];
        [self.view addSubview:label];
        
        self.userOrPswTextField = [[UITextField alloc] initWithFrame:CGRectMake(_wide / 3.125, _height / 11.12 + _height / 11.12 * i, _wide / 1.70, _height / 18)];
        _userOrPswTextField.borderStyle = UITextBorderStyleRoundedRect;
        _userOrPswTextField.placeholder = placeHolderArray[i];
        _userOrPswTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userOrPswTextField.tag = 1001 + i;
        if (i == 1) {
            _userOrPswTextField.secureTextEntry = YES;
        }
        [self.view addSubview:_userOrPswTextField];

    }
    
    
    // 登陆按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(20, self.view.frame.size.height / 3, self.view.frame.size.width - 40, 40);
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    // 处理登录按钮背景图片
    UIImage *normal = [UIImage imageNamed:@"RedButton"];
    UIImage *high = [UIImage imageNamed:@"RedButtonPressed"];
    // 切图
    normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.5];
    high = [high stretchableImageWithLeftCapWidth:high.size.width * 0.5 topCapHeight:high.size.width * 0.5];
    [loginBtn setBackgroundImage:normal forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:high forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rigist {
    NSLog(@"注册");
    RigisterViewController *rigisterVC = [[RigisterViewController alloc] init];
    [self.navigationController pushViewController:rigisterVC animated:nil];
}

// 登陆按钮响应的方法
- (void)login:(UIButton *)sender {
    NSLog(@"登陆");
    
    UITextField *userTextFiled = (UITextField *)[self.view viewWithTag:1001];
    UITextField *pswTextFiled = (UITextField *)[self.view viewWithTag:1002];
    
    FMDatabaseQueue *queue = [LNDataBaseManager shareData];
    // 根据姓名和密码去数据库中查找
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rb = [db executeQuery:@"select * from userInfo;", userTextFiled.text, pswTextFiled.text];
        while ([rb next]) {
            NSString *username = [rb stringForColumn:@"username"];
            NSString *password = [rb stringForColumn:@"password"];
            // 从数据库中找到用户名和密码
            if ([username isEqualToString:userTextFiled.text] && [password isEqualToString:pswTextFiled.text]) {
                NSLog(@"登陆成功");
                // 当我们点击视图的时候，让代理去执行协议里面的方法，并且把自身传过去
                if (_delegate != nil && [_delegate respondsToSelector:@selector(transerIsLogin:andUsername:)]) {
                    // 状态判断已经登录
                    self.isLogin = YES;
                    [_delegate transerIsLogin:self.isLogin andUsername:username];
                }
                [self dismissViewControllerAnimated:YES completion:nil];
                return;
            }
        }
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码错误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertVC addAction:defaultAction];
        [self presentViewController:alertVC animated:YES completion:nil];

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
