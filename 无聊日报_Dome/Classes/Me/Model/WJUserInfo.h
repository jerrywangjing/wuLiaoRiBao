//
//  WJUserInfo.h
//  无聊日报_Dome
//
//  Created by jerry on 16/7/6.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJUserInfo : NSObject

@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) UIImage * icon;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)infoWithDic:(NSDictionary *)dic;
@end
