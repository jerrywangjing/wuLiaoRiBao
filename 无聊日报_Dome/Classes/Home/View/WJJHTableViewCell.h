//
//  WJJHTableViewCell.h
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/2.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJTabelViewData.h"

@interface WJJHTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgeView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;

@property(nonatomic,strong)WJTabelViewData * data;

+(NSString * )reuseIdentifier;

@end
