//
//  WJGiftCollectionViewCell.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/29.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJGiftCollectionViewCell.h"
#import "WJGiftData.h"
#import "UIImageView+WebCache.h"

@interface WJGiftCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *priceBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
- (IBAction)likeBtnClick:(id)sender;

@end

@implementation WJGiftCollectionViewCell



- (void)awakeFromNib {
    // Initialization code
}

-(void)setGiftData:(WJGiftData *)giftData{

    _giftData = giftData;
    self.nameLabel.text = giftData.name;
    /**
     *  这个特别注意：给button的图片和title 赋值要调用setTitle：方法
     */
    NSString * priceStr = [NSString stringWithFormat:@"￥%@",giftData.price];
    
    [_priceBtn setTitle:priceStr forState:UIControlStateNormal];
    [_likeBtn setTitle:giftData.likeCount forState:UIControlStateNormal];

    // 图片使用三方库加载
    NSURL * imgUrl = [NSURL URLWithString:giftData.imgStr];
    [self.imgView sd_setImageWithURL:imgUrl];
    
}
- (IBAction)likeBtnClick:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"giftNoti" object:self.giftData];
}
@end
