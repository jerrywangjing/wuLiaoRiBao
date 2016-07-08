//
//  WJXiaoDianDiTableViewCell.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/28.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJXiaoDianDiTableViewCell.h"
#import "WJTabelViewData.h"
#import "UIImageView+WebCache.h"

@interface WJXiaoDianDiTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UIButton *cellBtn;

- (IBAction)cellBtnClick:(id)sender;

@end
@implementation WJXiaoDianDiTableViewCell

+(instancetype)homeCellWithTableView:(UITableView *)tableView{

    static NSString * ID = @"mainCell";
    
    WJXiaoDianDiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 在数据模型中加载xib cell
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WJXiaoDianDiTableViewCell" owner:nil options:nil] lastObject];
    }
    //取消cell 的选中高亮效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

// 通过cell的setter方法给UI控件加载数据
-(void)setCellData:(WJTabelViewData * )cellData{
    
    _cellData = cellData;
    self.cellLabel.text = cellData.title;
    self.cellBtn.titleLabel.text = cellData.likesCount;
    
    // 这里图片使用SDWebImage 三方类库管理
    NSURL * imgUrl = [NSURL URLWithString:cellData.imgUrl];
    [self.cellImage sd_setImageWithURL:imgUrl];
}


- (IBAction)cellBtnClick:(id)sender{

}

@end
