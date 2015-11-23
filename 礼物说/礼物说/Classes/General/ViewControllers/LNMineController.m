//
//  LNMineController.m
//  礼物说
//
//  Created by lanou3g on 15/11/19.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "LNMineController.h"
#import "LNLoginControlelr.h"
#import "LockController.h"
#import "LNDataBaseManager.h"

@interface LNMineController () <LoginDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) NSArray *listArray;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImagePickerController *imagePick;
@property (nonatomic, strong) UIImageView *imgView;
@end

static NSString *identifier = @"loginCell";

@implementation LNMineController

- (NSArray *)listArray {
    if (!_listArray) {
        _listArray = [NSArray arrayWithObjects:@"清除缓存", @"手势密码", @"关于", @"注销", nil];
    }
    return _listArray;
}

- (void)transerIsLogin:(BOOL)isLogin andUsername:(NSString *)username {
    if (isLogin) {
        self.nameLabel.text = username;
        FMDatabaseQueue *queue = [LNDataBaseManager shareData];
        [queue inDatabase:^(FMDatabase *db) {
            FMResultSet *rb = [db executeQuery:@"select *from userInfo;"];
            
            while ([rb next]) {
                NSString *user = [rb stringForColumn:@"username"];
                if ([user isEqualToString:self.nameLabel.text]) {
                    NSData *imgData = [rb dataForColumn:@"imgView"];
                    if (imgData) {
                        // 反归档
                        self.imgView.image = [UIImage imageWithData:imgData];
                    }

                }
            }
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加头视图
    UIImageView *hearderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 3)];
    hearderView.image = [UIImage imageNamed:@"minebackground.png"];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(hearderView.center.x - 40, hearderView.center.y - 50, 80, 100);
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    _imgView.image = [UIImage imageNamed:@"avatar_default"];
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = 40;
    [loginBtn addSubview:_imgView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 80, 20)];
    _nameLabel.text = @"登录";
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = UITextAlignmentCenter;
    [loginBtn addSubview:_nameLabel];
    [hearderView addSubview:loginBtn];
    self.tableView.tableHeaderView = hearderView;

    // 隐藏一个button，用来点击
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tempBtn.frame = CGRectMake(0, 0, 100, 100);
    [loginBtn addSubview:tempBtn];
    
    // 给头视图上面的imagView和label添加手势
    [tempBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView.userInteractionEnabled = YES;
    
    
    // 右边的设置button
//    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    settingBtn.frame = CGRectMake(self.view.frame.size.width - 50, 30, 30, 30);
//    [settingBtn setBackgroundImage:[UIImage imageNamed:@"Mylottery_config.png"] forState:UIControlStateNormal];
//    [settingBtn addTarget:self action:@selector(pushSetting) forControlEvents:UIControlEventTouchUpInside];
//    [hearderView addSubview:settingBtn];

    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
}


// 右边设置
//- (void)pushSetting {
//    NSLog(@"setting");
//}

- (void)login:(UITapGestureRecognizer *)sender {
    NSLog(@"登陆测试");
    if ([self.nameLabel.text isEqualToString:@"登录"]) {
        LNLoginControlelr *loginVC = [LNLoginControlelr new];
        loginVC.delegate = self;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    } else {
        self.imagePick = [[UIImagePickerController alloc] init];
        // 选中来源
        _imagePick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 是否可以被编辑
        _imagePick.allowsEditing = YES;
        _imagePick.delegate = self;
        [self presentViewController:self.imagePick animated:YES completion:nil];
    }
}

// 图片选择结束之后，走这个方法，字典存放所有图片信息
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imgView.image = img;
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@", info);
    
    [self uploadClick];
}

- (void)uploadClick {

    NSData *data = UIImagePNGRepresentation(_imgView.image);
    FMDatabaseQueue *queue = [LNDataBaseManager shareData];
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"update userInfo set imgView = ? where username = ?", data, self.nameLabel.text];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 0) {
        return self.listArray.count;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (indexPath.section == 0) {
        cell.textLabel.text = self.listArray[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"手势密码"]) {
        LockController *lockController = [[LockController alloc]init];
//        lockController.view.backgroundColor = [UIColor whiteColor];
        [self presentViewController:lockController animated:YES completion:nil];
    }
    if ([cell.textLabel.text isEqualToString:@"清除缓存"]) {
        NSUInteger size = [[SDImageCache sharedImageCache] getSize];
        NSString *cacheSize = [NSString stringWithFormat:@"清除缓存%luM", size / 1024 / 1024];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清除缓存" message:cacheSize preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:defaultAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        // 清除缓存
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDisk];
    }
    
    if ([cell.textLabel.text isEqualToString:@"关于"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"关于我" message:@"本App仅提供学习、技术交流、研究、欣赏，提供非商业性或非盈利性用途，如果发现本App侵犯到您的权益或者原创作者的文章不想显示在本App上，请及时联系我。\n\n QQ:1084126465 \n 非常感谢您的支持!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:defaultAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    if ([cell.textLabel.text isEqualToString:@"注销"]) {
        if (![self.nameLabel.text isEqualToString:@"登录"]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"是否退出登录" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.nameLabel.text = @"登录";
                self.imgView.image = [UIImage imageNamed:@"avatar_default"];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:defaultAction];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
            } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"用户未登录" message:@"无法注销" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:defaultAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
}


@end
