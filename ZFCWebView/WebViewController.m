//
//  WebViewController.m
//  ZFCWebView
//
//  Created by ZhaoFucheng on 14-8-27.
//  Copyright (c) 2014年 ZhaoFucheng. All rights reserved.
//

#import "WebViewController.h"


@interface WebViewController ()

@end

@implementation WebViewController

- (id)init
{
    self = [super init];
    if (self) {
        [self _initView];
    }
    return self;
}

/**
 * 初始化视图控件
 */
- (void)_initView
{
    _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [self.view addSubview:_navigationBar];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(5, 25, ScreenWidth - 10, 30)];
    self.searchBar.placeholder = @"搜索网站或输入网站名称";
    self.searchBar.delegate = self;
    self.searchBar.keyboardType = UIKeyboardTypeWebSearch;
    
    [_navigationBar addSubview:self.searchBar];
    
    _tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(0, ScreenHeight - 44, ScreenWidth, 44)];
    _leftItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"toolbar_leftarrow.png"] selectedImage:[UIImage imageNamed:@"toolbar_leftarrow_highlighted.png"]];
    _leftItem.tag = 0;
    _leftItem.enabled = NO;
    
    _rightItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"toolbar_rightarrow.png"] selectedImage:[UIImage imageNamed:@"toolbar_rightarrow_highlighted.png"]];
    _rightItem.tag = 1;
    _rightItem.enabled = NO;
    
    _refreshItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"toolbar_refresh.png"] selectedImage:[UIImage imageNamed:@"toolbar_refresh_highlighted.png"]];
    _refreshItem.tag = 2;
    _refreshItem.enabled = NO;
    _refreshItem.selectedImage = [UIImage imageNamed:@"toolbar_refresh_highlighted.png"];
    
    _tabBar.items = @[_leftItem,_rightItem,_refreshItem];
    _tabBar.delegate = self;
    [self.view addSubview:_tabBar];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 44)];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
    [self.view addSubview:self.webView];
    
    _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:_progressHUD];
    _progressHUD.delegate = self;
	_progressHUD.labelText = @"正在加载";
    
    [self loadWebViewWithURL:@"www.baidu.com"];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITabBarDelegate Methods
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item.tag == 0) {
        [self.webView goBack];
    }
    else if (item.tag == 1)
    {
        [self.webView goForward];
    }
    else if (item.tag == 2)
    {
        [self.webView reload];
    }
}

#pragma mark - Private Methods
- (void)loadWebViewWithURL:(NSString *)urlStr
{
    if (![urlStr hasPrefix:@"http://"]) {
        urlStr = [NSString stringWithFormat:@"http://%@",urlStr];
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    
    self.searchBar.text = [url host];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    [self.webView loadRequest:request];
}

#pragma mark - UISearchBarDelegate Methods
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self loadWebViewWithURL:searchBar.text];
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar resignFirstResponder];
}

#pragma mark - UIWebViewDelegate Methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_progressHUD show:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_progressHUD hide:YES];
    _refreshItem.enabled = YES;
    _leftItem.enabled = YES;
    _rightItem.enabled = YES;
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

#pragma mark - UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%g",scrollView.contentSize.height - scrollView.frame.size.height);
    NSLog(@"%g",scrollView.contentOffset.y);
//    CGRect frame = self.searchBar.frame;
//    frame.size.height = frame.size.height - scrollView.contentOffset.y / 10;
//    frame.size.width = frame.size.width - scrollView.contentOffset.y / 10;
//    self.searchBar.frame = frame;
//    self.searchBar.center = CGPointMake((ScreenWidth - 10 )/ 2 + 5,  30 / 2 + 25);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
