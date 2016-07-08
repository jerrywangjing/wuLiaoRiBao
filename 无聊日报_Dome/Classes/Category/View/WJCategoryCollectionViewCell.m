//
//  WJCategoryCollectionViewCell.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/31.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJCategoryCollectionViewCell.h"
#import "WJCategoryData.h"
#import "UIImageView+WebCache.h"

@interface WJCategoryCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end
@implementation WJCategoryCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    // cell 初始化完成后条用此方法
    self.imgView.backgroundColor = [UIColor whiteColor];
}

-(void)setCellData:(WJCategoryData *)cellData{

    self.nameLabel.text = cellData.name;
    
    NSURL * url = [NSURL URLWithString:cellData.bannerImg];
    [self.imgView sd_setImageWithURL:url];
}
@end
