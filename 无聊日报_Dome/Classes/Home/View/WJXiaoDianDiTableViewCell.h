//
//  WJXiaoDianDiTableViewCell.h
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/28.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJTabelViewData;
@interface WJXiaoDianDiTableViewCell : UITableViewCell

@property (nonatomic,strong) WJTabelViewData * cellData;

+(instancetype)homeCellWithTableView:(UITableView *)tableView;
@end
