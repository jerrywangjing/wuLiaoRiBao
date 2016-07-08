//
//  WJUserInfo.m
//  无聊日报_Dome
//
//  Created by jerry on 16/7/6.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJUserInfo.h"

@implementation WJUserInfo

-(instancetype)initWithDic:(NSDictionary *)dic{

    if (self = [super init]) {
        self.name = dic[@"name"];
        self.icon = dic[@"icon"];
    }
    return self;
}

+(instancetype)infoWithDic:(NSDictionary *)dic{

    return [[self alloc] initWithDic:dic];
}
@end
