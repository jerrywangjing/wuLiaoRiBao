//
//  WJSettingData.h
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/12.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJSettingData : NSObject
@property (nonatomic,strong) NSString * imgStr;
@property (nonatomic,strong) NSString * title;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)settingDataWithDic:(NSDictionary *)dic;
@end
