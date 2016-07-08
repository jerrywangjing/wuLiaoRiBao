//
//  WJMyMsgViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/9.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJMyMsgViewController.h"

@interface WJMyMsgViewController ()

@end

@implementation WJMyMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的消息";
    [self addMsgEmptyView];
    
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}
-(void)addMsgEmptyView{

    //图片
    UIImageView * msg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_notification_null~iphone"]];
    CGFloat heartWH = 40;
    CGFloat heartX = (SCREEN_WIDTH - heartWH)/2;
    CGFloat heartY = 200;
    msg.frame = CGRectMake(heartX, heartY, heartWH, heartWH);
    // 文字
    CGFloat labelW = 120;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - labelW)/2, CGRectGetMaxY(msg.frame)+10, labelW, 20)];
    label.text = @"您还没有消息呢...";
    label.textColor = LCColorForTabBar(200, 200, 200);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    
    [self.view addSubview:label];
    [self.view addSubview:msg];

}
@end
