//
//  WJRegistViewController.h
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/7.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol registAccountDelegate <NSObject>
@optional

-(void)saveAccountWithPhoneNum:(NSString * )phoneNum addPwd:(NSString *)pwd;
@end

@interface WJRegistViewController : UIViewController
// 代理对象
@property (nonatomic,weak) id<registAccountDelegate> delegate;

@end
