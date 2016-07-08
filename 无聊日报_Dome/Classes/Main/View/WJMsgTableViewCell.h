//
//  WJMsgTableViewCell.h
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/3.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJMsgCellData;
@interface WJMsgTableViewCell : UITableViewCell

@property (nonatomic,strong) WJMsgCellData * cellData;
@property (nonatomic,assign) CGFloat rowHeight;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
