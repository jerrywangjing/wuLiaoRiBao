//
//  WJMsgTableViewCell.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/3.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJMsgTableViewCell.h"
#import "WJMsgCellData.h"

@interface WJMsgTableViewCell ()

@property (nonatomic,weak) UIImageView * iconImg;
@property (nonatomic,weak) UILabel * name;
@property (nonatomic,weak) UILabel * content;

@end
@implementation WJMsgTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
     NSString * ID = @"msgCell";
    WJMsgTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[ WJMsgTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

// 初始化cell 子控件
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 创建子控件
            // 头像
        UIImageView * iconImg = [[UIImageView alloc] init];
        [self.contentView addSubview:iconImg];
        iconImg.layer.cornerRadius = 20;
        iconImg.layer.masksToBounds = YES;
        self.iconImg = iconImg;
            // 名字
        UILabel * name = [[UILabel alloc] init];
        [self.contentView addSubview:name];
        name.font = [UIFont systemFontOfSize:15];
        name.textColor = LCColorForTabBar(100, 100, 100);
        self.name = name;
            // 内容
        UILabel * content = [[UILabel alloc] init];
        [self.contentView  addSubview:content];
        content.font = [UIFont systemFontOfSize:13];
        content.numberOfLines = 0;// 设置自动换行
        content.textColor = LCColorForTabBar(100, 100, 100);
        self.content = content;
    }
    
    return self;
}
-(void)setCellData:(WJMsgCellData *)cellData{

    // 给子控件赋值
    
    NSURL * imgUrl = [NSURL URLWithString:cellData.iconImg];
    [self.iconImg sd_setImageWithURL:imgUrl];
    self.name.text = cellData.name;
    self.content.text = cellData.content;
    // 设置子控件的frame
    [self setMsgContentFrame];
    
}
-(void)setMsgContentFrame{

    // 头像frame
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    CGFloat iconX = 10;
    CGFloat iconY = 10;
    CGFloat margin = 10;
    
    self.iconImg.frame = CGRectMake(iconX, iconY, iconW, iconH);
    // 名称 frame
    CGFloat nameX = CGRectGetMaxX(self.iconImg.frame) +margin;
        // 获取名字的大小
    CGSize nameSize = [self sizeWithText:self.name.text maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) fontSize:15];
    
    self.name.frame = CGRectMake(nameX, iconY, nameSize.width, nameSize.height);
    
    // 内容frame
    CGSize contentSize = [self sizeWithText:self.content.text maxSize:CGSizeMake(SCREEN_WIDTH-(iconW + 3*margin), MAXFLOAT) fontSize:13];
    CGFloat contentX = self.name.frame.origin.x;
    CGFloat contentY = CGRectGetMaxY(self.name.frame) +margin;
    self.content.frame = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    _rowHeight = CGRectGetMaxY(self.content.frame) +margin;
}

// 计算文字的大小
-(CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize{
    
    //CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);//float的最大值
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;//根据字体的数目计算所属lable的大小(size)
    return size;
}
@end
