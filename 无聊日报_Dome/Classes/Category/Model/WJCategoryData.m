//
//  WJCategoryData.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/1.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJCategoryData.h"

@implementation WJCategoryData

-(instancetype)initWithDic:(NSDictionary *)dic{

    if (self = [super init]) {
        self.bannerImg = dic[@"icon_url"];
        self.name  = dic[@"name"];
        self.imgUrl = dic[@"cover_image_url"];
        self.title = dic[@"title"];
        // 这里注意转换
        NSInteger fCount = [dic[@"likes_count"] integerValue];
        NSString * countStr = [NSString stringWithFormat:@"%ld",fCount];
        self.content_url = dic[@"content_url"];

        self.likesCount = countStr;
        self.cover_image_url = dic[@"cover_image_url"];
        self.liked = dic[@"liked"];
    }
    return self;
}
+(instancetype)categoryCellWithDic:(NSDictionary *)dic{

    return [[self alloc] initWithDic:dic];
}
@end
