//
//  WJJinXuanTableViewCell.h
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/24.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJTabelViewData;

@interface WJJinXuanTableViewCell : UITableViewCell

@property (nonatomic,strong) WJTabelViewData * cellData;

+(instancetype)homeCellWithTableView:(UITableView *)tableView;
@end
