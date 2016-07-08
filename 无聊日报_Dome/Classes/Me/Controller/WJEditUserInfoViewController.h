//
//  WJEditUserInfoViewController.h
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/10.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJUserInfo;
@protocol editViewDelegate <NSObject>

@optional
-(void)changeUserNameValue:(NSString *)userName;
-(void)changeUserIconimage:(UIImage *)iconImage;

@end
@interface WJEditUserInfoViewController : UIViewController

@property (nonatomic,strong) UIImageView * iconImg;
@property (nonatomic,strong) UILabel * userName;
@property (nonatomic,weak) id<editViewDelegate> delegate;
@property (nonatomic,strong)  WJUserInfo * infoData;

@end
