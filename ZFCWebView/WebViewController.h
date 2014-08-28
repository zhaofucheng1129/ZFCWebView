//
//  WebViewController.h
//  ZFCWebView
//
//  Created by ZhaoFucheng on 14-8-27.
//  Copyright (c) 2014年 ZhaoFucheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"

@interface WebViewController : UIViewController <UISearchBarDelegate,UIWebViewDelegate,UIScrollViewDelegate,UITabBarDelegate,MBProgressHUDDelegate>
{
    UINavigationBar *_navigationBar;
    UITabBar *_tabBar;
    AVAudioPlayer *_audioPlayer;
    
    UITabBarItem *_leftItem;
    UITabBarItem *_rightItem;
    UITabBarItem *_refreshItem;
    
    MBProgressHUD *_progressHUD;
}

@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) UISearchBar *searchBar;

@end
