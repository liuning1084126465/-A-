//
//  LNClassifyController.m
//  礼物说
//
//  Created by lanou3g on 15/11/17.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "LNClassifyController.h"
#import "ClassifyReusableView.h"
#import "ClassifyManager.h"
#import "ClassifyCell.h"
#import "LNClassifyListController.h"
#import "LNClassifyModel.h"

@interface LNClassifyController ()

@end

@implementation LNClassifyController

static NSString * const reuseIdentifier = @"Cell";
// header重用标识符
static NSString *headerIdentifier = @"headerReuse";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor blueColor];
    self.view.backgroundColor = [UIColor whiteColor];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    // 创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置item
    layout.itemSize = CGSizeMake(self.view.frame.size.width / 4 - 10, self.view.frame.size.width / 4 + 20);
    // UICollectionView
    // 设置header区域大小(当滚动方向为水平滚动的时候，20有用； 当滚动方向为垂直的时候，20有用)
    layout.headerReferenceSize = CGSizeMake(20, 30);

    // 创建collectionView之前，必须先创建描述对象
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    // 默认是黑色，改成白色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[ClassifyCell class] forCellWithReuseIdentifier:reuseIdentifier];
    // 注册增补视图头部
    [self.collectionView registerClass:[ClassifyReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    // Do any additional setup after loading the view.
    
    [ClassifyManager sharedManager].updataBlock = ^(){
        [self.collectionView reloadData];
    };
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return [ClassifyManager sharedManager].classifyNameArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    NSArray *array = [ClassifyManager sharedManager].dataArray[section];
    return array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassifyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    NSArray *array = [ClassifyManager sharedManager].dataArray[indexPath.section];
    cell.classifyModel = array[indexPath.row];
    return cell;
}


// 设置item内边距大小(上左下右) 和layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5); 一样，但是用属性设置太过于局限
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

// 返回增补视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        // 从重用池取出来
        //        UICollectionReusableView *headerReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        ClassifyReusableView *headerReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        headerReusableView.titleLabel.text = [ClassifyManager sharedManager].classifyNameArray[indexPath.section];
        return headerReusableView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = [ClassifyManager sharedManager].dataArray[indexPath.section];
    LNClassifyModel *classifyModel = array[indexPath.row];
    
    
    LNClassifyListController *listVC = [[LNClassifyListController alloc] init];
    // 传值
    listVC.titleName = classifyModel.name;
    listVC.ID = classifyModel.ID;
    [self.navigationController pushViewController:listVC animated:YES];
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
