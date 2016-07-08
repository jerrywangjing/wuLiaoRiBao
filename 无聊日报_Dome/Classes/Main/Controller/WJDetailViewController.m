//
//  WJDetailViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/26.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "WJTabelViewData.h"
#import "WJMsgTableViewController.h"
#import "WJNavigationController.h"
#import "WJDetailToolBar.h"
#import "UMSocial.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define BGIMAGE_HEIGHT 160

@interface WJDetailViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIWebView * webView;
@property (nonatomic,strong) UIImageView * imgView;
@property (nonatomic,strong) UILabel * label;
@property (nonatomic,assign) BOOL isLiked;

@property (nonatomic,strong) WJDetailToolBar * detailToolBar;


@end


@implementation WJDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"攻略详情";
    // 去掉底部tabBar
    self.hidesBottomBarWhenPushed = YES;
    // 添加toolbar
    [self creatToolBar];
    // 喜欢按钮默认是未选中
    self.isLiked = self.detailData.liked;
    self.webView.backgroundColor = [UIColor whiteColor];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}
-(UILabel *)label{

    if (!_label) {
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.imgView.frame)-30, SCREEN_WIDTH, 20)];
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;// 文字居中
        _label.font = [UIFont systemFontOfSize:15];
        [self.imgView addSubview:_label];
    }
    return _label;
}
-(UIImageView *)imgView{

    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -160, SCREEN_WIDTH, BGIMAGE_HEIGHT)];
        //_imgView.contentScaleFactor = 2.0; // 内容缩放比例
        _imgView.contentMode = UIViewContentModeScaleAspectFill;//设置图片宽高比相等缩放即等比缩放
        [self.webView.scrollView addSubview:_imgView];//注意这里是添加到webView的scrollView上的
    }
    return _imgView;
}

-(UIWebView *)webView{
    
    if (!_webView) {
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _webView.scrollView.contentInset = UIEdgeInsetsMake(160, 0, 0, 0);
        _webView.scrollView.delegate = self;
        _webView.scrollView.maximumZoomScale = 2.0;
        _webView.scrollView.minimumZoomScale = 0.2;
        [self.view addSubview:_webView];
        
    }
    return _webView;
}

// 重写detailData模型的setter 给子视图赋值
-(void)setDetailData:(WJTabelViewData *)detailData{

    _detailData = detailData;
    
    // 给子控件赋值
    if (!self.webView.request) {
        
        NSURL * url = [NSURL URLWithString:detailData.content_url];
        NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:urlRequest];

    }
    
    self.label.text = detailData.title;
    
    NSString * imgStr = detailData.cover_image_url;
    NSURL * imgUrl = [NSURL URLWithString:imgStr];
    [self.imgView sd_setImageWithURL:imgUrl];
}
// 当关闭详情页的时候释放到占用内存比较大的视图
//-(void)viewWillDisappear:(BOOL)animated{
//
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    // 注意实现缩放之前要 webView.scrollView.delegate = self; 指定代理

    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat offsetH = BGIMAGE_HEIGHT + offsetY;

    if (offsetH < 0) {
        CGRect frame = self.imgView.frame;
        frame.size.height = BGIMAGE_HEIGHT - offsetH;
        frame.origin.y = -BGIMAGE_HEIGHT + offsetH;
        self.imgView.frame = frame;
        // 同时更改label的y值让其也向下移
        CGRect frameLabel = self.label.frame;
        frameLabel.origin.y = (BGIMAGE_HEIGHT-30) -offsetH;
        self.label.frame = frameLabel;
    }
    
}

#pragma mark -- toolBar创建&代理方法

-(void)creatToolBar{

    WJDetailToolBar * toolBar = [[WJDetailToolBar alloc] init];
    toolBar.frame = CGRectMake(0, self.webView.frame.size.height -(44+64), SCREEN_WIDTH, 44);
    _detailToolBar = toolBar;
    
    // 添加按钮
    [self creatToolBarButton];

    [self.webView addSubview:toolBar];
}
-(void)creatToolBarButton{

    // 创建按钮
    // 喜欢按钮
    UIButton * heartBtn = [self toolBarBtn:[UIImage imageNamed:@"PostItem_Like~iphone"] andHlt:nil with:self.detailData.likesCount];
    CGFloat btnW = 90;
    CGFloat btnH = 20;
    CGFloat btnY = (self.detailToolBar.frame.size.height - btnH)/2;
    CGFloat margin = (SCREEN_WIDTH/3-btnW) /2;
    heartBtn.frame = CGRectMake(margin, btnY, btnW, btnH);
    [heartBtn addTarget:self action:@selector(heartBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        // 设置高亮的时候不要让按钮图标变色
    heartBtn.adjustsImageWhenHighlighted = NO;

    // 分享按钮
    UIButton * shareBtn = [self toolBarBtn:[UIImage imageNamed:@"Post_ShareIcon~iphone"] andHlt:nil with:@"25"];
    CGFloat shareBtnX = margin * 3 + btnW;
    shareBtn.frame = CGRectMake(shareBtnX, btnY, btnW, btnH);
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.adjustsImageWhenHighlighted = NO; // 关闭高亮显示状态
    // 消息按钮
    UIButton * commentBtn = [self toolBarBtn:[UIImage imageNamed:@"content-details_comments"] andHlt:nil with:@"333"];
    CGFloat messBtnX = SCREEN_WIDTH -(btnW + margin);
    commentBtn.frame = CGRectMake(messBtnX, btnY, btnW, btnH);
    [commentBtn addTarget:self action:@selector(commentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    commentBtn.adjustsImageWhenHighlighted = NO; // 关闭高亮显示状态
    
    [_detailToolBar addSubview:heartBtn];
    [_detailToolBar addSubview:shareBtn];
    [_detailToolBar addSubview:commentBtn];
}

// 创建按钮方法
-(UIButton * )toolBarBtn:(UIImage *)imgNor andHlt:(UIImage * )imgHelt with:(NSString * )numStr{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:imgNor forState:UIControlStateNormal];
    [btn setImage:imgHelt forState:UIControlStateHighlighted];
    [btn setTitle:numStr forState:UIControlStateNormal];
    [btn setTitleColor:LCColorForTabBar(180, 180, 180) forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
    return btn;
}

#pragma mark -- toolbar按钮点击事件
-(void)heartBtnClick:(UIButton *)sender{
    
    UIButton * btn = sender;
    
    if (!self.isLiked) {
        [btn setImage:[UIImage imageNamed:@"PostItem_Liked~iphone"] forState:UIControlStateNormal];
        self.isLiked = YES;
    }else{
    
        [btn setImage:[UIImage imageNamed:@"PostItem_Like~iphone"] forState:UIControlStateNormal];
        self.isLiked = NO;
    }
    
    // me tableView 发出添加喜欢通知，并携带相应数据对象
    [[NSNotificationCenter defaultCenter] postNotificationName:@"lickNoti" object:self.detailData];
    
}
-(void)shareBtnClick{
    
    // 弹出分享窗口
    NSArray * shareArr = [NSArray arrayWithObjects:UMShareToWechatTimeline,UMShareToWechatSession,UMShareToSina,UMShareToQzone,UMShareToQQ, nil];
    
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"571f7bcce0f55ad4a9003503" shareText:@"友盟分享" shareImage:[UIImage imageNamed:@"dropdown_anim__00010"] shareToSnsNames:shareArr delegate:nil];
    
}
-(void)commentBtnClick{
    
    // 弹出 消息模态视图
    WJMsgTableViewController * msgVC = [[WJMsgTableViewController alloc] init];

    WJNavigationController * navVC = [[WJNavigationController alloc] initWithRootViewController:msgVC];

    [self.navigationController presentViewController:navVC animated:YES
                                          completion:nil];

}
#pragma mark -- 社会化分享视图创建

@end
