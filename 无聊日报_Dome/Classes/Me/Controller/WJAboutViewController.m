//
//  WJAboutViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/13.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJAboutViewController.h"

@interface WJAboutViewController ()

@end

@implementation WJAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"关于";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubViews];
}

-(void)addSubViews{

    UIImageView * img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userIcon"]];
    CGFloat imgWH = 60;
    CGFloat imgX = (SCREEN_WIDTH - imgWH)/2;
    CGFloat imgY = 100;
    img.frame = CGRectMake(imgX, imgY, imgWH, imgWH);
    img.layer.cornerRadius = 10;
    img.layer.masksToBounds = YES;
    
    CGFloat infoX = (SCREEN_WIDTH - 200)/2;
    UILabel * info = [[UILabel alloc] initWithFrame:CGRectMake(infoX, CGRectGetMaxY(img.frame) +20, 200, 20)];
    info.text = @"无聊日报 v1.0(9)";
    info.textAlignment = NSTextAlignmentCenter;// 文字居中
    info.font = [UIFont systemFontOfSize:16];
    
    [self.view addSubview:img];
    [self.view addSubview:info];
}
@end
