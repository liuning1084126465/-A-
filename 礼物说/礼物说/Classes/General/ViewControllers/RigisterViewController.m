//
//  RigisterViewController.m
//  豆瓣应用
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "RigisterViewController.h"
#import "LNDataBaseManager.h"

@interface RigisterViewController ()
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UITextField *textField;
//@property (nonatomic, retain) UserDataBase *dataBase;
@property (nonatomic, strong) FMDatabaseQueue *queue;
@end

@implementation RigisterViewController

// 自定义视图
- (void)customView {
    
    NSArray *labelArray = @[@"用户名", @"密码", @"确认密码", @"邮箱", @"联系方式"];
    NSArray *textFieldArray = @[@"请输入用户名", @"请输入密码", @"请确认密码", @"请输入邮箱", @"请输入电话"];
    for (int i = 0 ; i < 5; i++) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 10, 50 + 60 * i, 80, 40)];
        _label.text = labelArray[i];
        [self.view addSubview:_label];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 10 + 80, 50 + 60 * i, 200, 40)];
        _textField.placeholder = textFieldArray[i];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.tag = 1001 + i; // 设定tag值，便于后面获取
        if (i == 1 || i == 2) {
            _textField.secureTextEntry = YES;
        }
        if (i == 3) {
            _textField.keyboardType = UIKeyboardTypeEmailAddress;
        }
        if (i == 4) {
            _textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        [self.view addSubview:_textField];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<用户登陆" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rigister:)];
    
    [self customView];
}

// 返回导航按钮
- (void)back:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// 注册按钮
- (void)rigister:(UIBarButtonItem *)sender   {
    UITextField *userNameTextField = (UITextField *)[self.view viewWithTag:1001];
    UITextField *passwordTextField = (UITextField *)[self.view viewWithTag:1002];
    UITextField *surePasswordTextField = (UITextField *)[self.view viewWithTag:1003];
    UITextField *emailTextField = (UITextField *)[self.view viewWithTag:1004];
    UITextField *phoneNumberTextField = (UITextField *)[self.view viewWithTag:1005];
    if (userNameTextField.text.length != 0 && passwordTextField.text.length != 0 && [passwordTextField.text isEqualToString:surePasswordTextField.text]) {
        self.queue = [LNDataBaseManager shareData];
        // 把东西插入数据库中
        [self.queue inDatabase:^(FMDatabase *db) {
            [db executeUpdate:@"insert into userInfo (username, password, email, telephone) values (?, ?, ?, ?);", userNameTextField.text, passwordTextField.text, emailTextField.text, phoneNumberTextField.text];
        }];
        [self.navigationController popViewControllerAnimated:YES];
        
    } else if (userNameTextField.text.length != 0 && passwordTextField.text.length != 0 && ![passwordTextField.text isEqualToString:surePasswordTextField.text]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登陆失败" message:@"密码和确认密码不相同" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureButton = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:sureButton];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登陆失败" message:@"用户名和密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureButton = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:sureButton];
        [self presentViewController:alertController animated:YES completion:nil];
    }
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
