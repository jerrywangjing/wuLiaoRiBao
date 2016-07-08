//
//  WJSettingTableViewCell.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/12.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJSettingTableViewCell.h"
#import "WJSettingData.h"

@interface WJSettingTableViewCell ()

@property (nonatomic,strong) UISwitch * switchView;
@property (nonatomic,strong) UILabel * subTitle;

@end

@implementation WJSettingTableViewCell

-(UISwitch *)switchView{

    if (!_switchView) {
        _switchView = [[UISwitch alloc] init];
        // 监听switch变化
        [_switchView addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

-(void)valueChanged:(UISwitch *)switchView{

    // 把开关状态保存到偏好设置中
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchView.isOn forKey:self.settingData.title];
}

-(UILabel *)subTitle{

    if (!_subTitle) {
        _subTitle = [[UILabel alloc] init];
    }
    return _subTitle;
}

// 在数据模型的setter方法中给view赋值
-(void)setSettingData:(WJSettingData *)settingData{

    _settingData = settingData;
    
    self.textLabel.text = settingData.title;
    self.imageView.image = [UIImage imageNamed:settingData.imgStr];
    
    
}
@end
