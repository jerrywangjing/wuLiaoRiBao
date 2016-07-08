//
//  WJDetailImgViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/30.
//  Copyright © 2016年 JerryWang. All rights reserved.
//
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

#import "WJDetailImgViewController.h"
#import "DCPicScrollView.h"

@interface WJDetailImgViewController ()

@end

@implementation WJDetailImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self autoScrollPic];
}


-(void)autoScrollPic{

    // 图片数组
    NSArray * picArr = @[@"http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150717/ersqeu575.jpg-w720",@"http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150729/ipds0i95t.jpg-w720"];
    
    // 创建轮播图
    DCPicScrollView * picScrollView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH) WithImageUrls:picArr];
    
    // 图片点击事件
    [picScrollView setImageViewDidTapAtIndex:^(NSInteger index) {
        // 实现图片点击事件
    }];
    //default is 2.0f,如果小于0.5不自动播放
    picScrollView.AutoScrollDelay = 0.1f;
    
    [self.view addSubview:picScrollView];
    
}
@end
