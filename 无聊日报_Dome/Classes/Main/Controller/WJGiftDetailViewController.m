//
//  WJGiftDetailViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/29.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJGiftDetailViewController.h"
#import "WJDetailImgViewController.h"
#import "WJGiftData.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface WJGiftDetailViewController ()
@property (nonatomic,strong) UIWebView * webView;
//@property (nonatomic,strong) WJDetailImgViewController * headImage;



@end

@implementation WJGiftDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.hidesBottomBarWhenPushed = YES;
}
-(UIWebView *)webView{

    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
        _webView.scrollView.backgroundColor = [UIColor whiteColor];
            
        [self.view addSubview:_webView];
    }
    return _webView;
}

// 给属性赋值
-(void)setGiftData:(WJGiftData *)giftData{

    _giftData = giftData;
    
    NSURL * url = [NSURL URLWithString:giftData.url];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    self.view.backgroundColor  = [UIColor whiteColor];

    [self shareBtn];

    
}

// 分享按钮
-(void)shareBtn{

    UIBarButtonItem * shareBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Post_ShareIcon~iphone"] style:UIBarButtonItemStylePlain target:self action:@selector(shareClick)];
    self.navigationItem.rightBarButtonItem = shareBtn;
}

-(void)shareClick{

}
@end
