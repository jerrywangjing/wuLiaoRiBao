//
//  WJGiftData.h
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/29.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJGiftData : NSObject

@property (nonatomic,copy) NSString * imgStr;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * likeCount;
@property (nonatomic,copy) NSString * descrp;
@property (nonatomic,copy) NSString * url;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)GiftDataWithDic:(NSDictionary *)dic;
@end
