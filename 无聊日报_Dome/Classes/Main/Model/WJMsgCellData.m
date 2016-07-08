//
//  WJMsgCellData.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/3.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJMsgCellData.h"

@implementation WJMsgCellData

-(instancetype)initWithDic:(NSDictionary *)dic{

    if (self= [super init]) {
        self.content = dic[@"content"];
        self.iconImg = dic[@"iconImg"];
        self.name = dic[@"name"];
    }
    return self;
}

+(instancetype)msgCellWithDic:(NSDictionary *)dic{

    return [[self alloc] initWithDic:dic];
}
@end
