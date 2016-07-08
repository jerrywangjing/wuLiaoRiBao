//
//  WJJHTableViewCell.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/2.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJJHTableViewCell.h"

@implementation WJJHTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];

    return self;
}

+(NSString * )reuseIdentifier {

    NSString * str =@"reuseIdentifier";
    return str;

}

-(void)setData:(WJTabelViewData *)data {
    _data =data;
    [_imgeView sd_setImageWithURL:[NSURL URLWithString:data.imgUrl]];
    _nameLabel.text = data.title;
    [_likeBtn setTitle:data.likesCount forState:UIControlStateNormal];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
