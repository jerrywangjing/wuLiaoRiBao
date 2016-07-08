//
//  WJNavigationController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/22.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJNavigationController.h"

@interface WJNavigationController ()

@end

@implementation WJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 设置全局导航条颜色
    UINavigationBar * navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    navBar.backIndicatorImage = [UIImage imageNamed:@"Scan_btn_back_nav~iphone"];
    // 2.设置全局导航条标题的字体和颜色
    NSDictionary * titleAttr = @{
     NSForegroundColorAttributeName:[UIColor whiteColor],
     NSFontAttributeName:[UIFont systemFontOfSize:18]
                                 };
    [navBar setTitleTextAttributes:titleAttr];
    // 3.设置返回按钮的样式
    // 设置导航条item的涂染色，应用于导航条的所有item
    navBar.tintColor = [UIColor whiteColor];

}

// 设置App状态栏样式为亮色
-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}
@end
