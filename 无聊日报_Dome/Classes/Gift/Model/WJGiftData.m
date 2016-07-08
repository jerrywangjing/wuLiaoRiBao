//
//  WJGiftData.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/29.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJGiftData.h"
#import "SDImageCache.h"

@implementation WJGiftData

-(instancetype)initWithDic:(NSDictionary *)dic{

    if (self = [super init]) {
        self.name = dic[@"name"];
        self.descrp = dic[@"description"];
        self.imgStr = dic[@"cover_image_url"];
        self.price = dic[@"price"];
            // 这里注意转换
        NSInteger fCount = [dic[@"favorites_count"] integerValue];
        NSString * countStr = [NSString stringWithFormat:@"%ld",fCount];
        self.likeCount = countStr;
        self.url = dic[@"url"];
    }
    return self;
}

+(instancetype)GiftDataWithDic:(NSDictionary *)dic{

    return [[self alloc] initWithDic:dic];
}
@end
