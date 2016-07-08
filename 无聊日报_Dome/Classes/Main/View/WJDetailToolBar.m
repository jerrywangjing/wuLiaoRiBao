//
//  WJDetailToolBar.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/26.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJDetailToolBar.h"

@implementation WJDetailToolBar

-(instancetype)init{

    if (self = [super init]) {
        self =  (WJDetailToolBar *)[self detailToolbar];
    }
    return self;
}
// 详情视图toolbar
-(UIView *)detailToolbar{
    
    UIView * detailBar = [[UIView alloc] init];
    detailBar.backgroundColor = [UIColor whiteColor];
    // 添加间隔线条
    UIView * lineHrzi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineHrzi.backgroundColor = LCColorForTabBar(180, 180, 180); // 设置工具栏黑色间隔线条
    
    for (int i = 0; i<2; i++) {
        
        UIImageView * line  =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"content-details_line~iphone"]];
        line.frame = CGRectMake(SCREEN_WIDTH/3*(i+1), 10, 1, 20);
        [detailBar addSubview:line];
    }
 
    //[_commentBtn addTarget:self action:@selector(messageClick:) forControlEvents:UIControlEventTouchUpInside];
    // 添加按钮到toolbar

    [detailBar addSubview:lineHrzi];
    
    return detailBar;
    
}
@end
