//
//  WJTabelViewData.h
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/25.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJTabelViewData : NSObject
@property (nonatomic,copy) NSString * imgUrl;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,assign) bool liked;
@property (nonatomic,copy) NSString * likesCount;
@property (nonatomic,copy) NSString * content_url;
@property (nonatomic,copy) NSString * cover_image_url;


-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)homeCellWithDic:(NSDictionary *)dic;

@end
