//
//  WJJinXuanTableViewCell.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/24.
//  Copyright © 2016年 JerryWang. All rights reserved.
//



#import "WJJinXuanTableViewCell.h"
#import "WJTabelViewData.h"
#import "UIImageView+WebCache.h"

@interface WJJinXuanTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UIButton *cellBtn;

- (IBAction)cellBtnClick:(id)sender;


@end

@implementation WJJinXuanTableViewCell

+(instancetype)homeCellWithTableView:(UITableView *)tableView{

    static NSString * ID = @"mainCell";
    
    WJJinXuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 在数据模型中加载xib cell
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WJJinXuanTableViewCell" owner:nil options:nil] lastObject];
    }
    //取消cell 的选中高亮效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 注意cell 中图片倒圆角是在xib中设置的
    return cell;
}

// 通过cell的setter方法给UI控件加载数据
-(void)setCellData:(WJTabelViewData * )cellData{

    _cellData = cellData;
    
    self.cellLabel.text = cellData.title;
    [self.cellBtn setTitle:cellData.likesCount forState:UIControlStateNormal];
    // 这里图片使用SDWebImage 三方类库管理
    NSURL * imgUrl = [NSURL URLWithString:cellData.imgUrl];
    [self.cellImage sd_setImageWithURL:imgUrl];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)cellBtnClick:(id)sender {
    
}
@end
