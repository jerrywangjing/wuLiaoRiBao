//
//  WJTabelViewData.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/25.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJTabelViewData.h"

@implementation WJTabelViewData

-(instancetype)initWithDic:(NSDictionary *)dic{

    if (self = [super init]) {
        self.imgUrl = dic[@"cover_image_url"];
        self.title = dic[@"title"];
            // 注意这里的转化：从字典里取出的都是对象，比如数字，可能是NSNumber对象 需要转为NSInteger 长整型，然后在用stringWithFormat转为字符串
        
        NSInteger inter = [dic[@"likes_count"] integerValue];
        NSString * countStr = [NSString stringWithFormat:@"%ld",inter];
        self.likesCount = countStr;
        self.content_url = dic[@"content_url"];
        self.cover_image_url = dic[@"cover_image_url"];
        self.liked = dic[@"liked"];
    }
    return self;
}

+(instancetype)homeCellWithDic:(NSDictionary *)dic{

    return [[self alloc] initWithDic:dic];
}

@end
