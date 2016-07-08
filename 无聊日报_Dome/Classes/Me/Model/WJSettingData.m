//
//  WJSettingData.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/12.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJSettingData.h"

@implementation WJSettingData

-(instancetype)initWithDic:(NSDictionary *)dic{

    if (self = [super init]) {
        self.imgStr = dic[@"image"];
        self.title = dic[@"title"];
    }
    return self;
}
+(instancetype)settingDataWithDic:(NSDictionary *)dic{

    return [[self alloc] initWithDic:dic];
}
@end
