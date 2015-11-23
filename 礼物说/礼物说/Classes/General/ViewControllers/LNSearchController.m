//
//  LNSearchController.m
//  礼物说
//
//  Created by lanou3g on 15/11/21.
//  Copyright © 2015年 liuning.com. All rights reserved.
//

#import "LNSearchController.h"

@interface LNSearchController () <UISearchBarDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation LNSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_webView];
    
    // 定义UIWebView
    // 默认URL，淘宝搜索框
//    NSURL *nomalURL = [NSURL URLWithString:@"http://m.taobao.com"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:nomalURL];
//    [self.webView loadRequest:request];
    
    // 左边返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    // 右边搜索按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(search)];
//     定义searchBar
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(50, 0, self.view.frame.size.width - 100, 44)];
    _searchBar.placeholder = @"搜索礼物、攻略";
    _searchBar.delegate = self;
    [self.navigationController.navigationBar addSubview:_searchBar];
}

// 左边返回
- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 右边搜索
- (void)search {
    NSLog(@"%@", self.searchBar.text);
    [self loadStringURL:self.searchBar.text];
}

// 让浏览器加载指定的字符串,使用m.baidu.com进行搜索
// 让浏览器加载指定的字符串,使用m.baidu.com进行搜索
- (void)loadStringURL:(NSString *)str
{
    // 1. URL 定位资源,需要资源的地址
    NSString *urlStr = str;
    if (![str hasPrefix:@"http://"]) {
        urlStr = [NSString stringWithFormat:@"http://m.baidu.com/s?word=%@", str];
    }
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
}
#pragma mark 代理中的方法
// 文字编辑的时候
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"searchText == %@", searchText);
}
// 点击键盘上面搜索的时候
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self loadStringURL:searchBar.text];
}



@end
