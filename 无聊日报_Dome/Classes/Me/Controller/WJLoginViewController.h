//
//  WJLoginViewController.h
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/5.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol loginViewDelegate <NSObject>
@optional
-(void)changeUserInfoWithImg:(UIImage *)iconImg addName:(NSString *)name;
-(void)presentViewToTabelView;
@end
@interface WJLoginViewController : UIViewController

@property (nonatomic,weak) id<loginViewDelegate> delegate;

@end
