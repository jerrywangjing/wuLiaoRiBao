//
//  WJCategoryData.h
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/1.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJCategoryData : NSObject
@property (nonatomic,copy) NSString * bannerImg;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * imgUrl;
@property (nonatomic,copy) NSString * likesCount;
@property (nonatomic,copy) NSString * content_url;
@property (nonatomic,copy) NSString * cover_image_url;
@property (nonatomic,assign) BOOL  liked;



-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)categoryCellWithDic:(NSDictionary *)dic;
@end
