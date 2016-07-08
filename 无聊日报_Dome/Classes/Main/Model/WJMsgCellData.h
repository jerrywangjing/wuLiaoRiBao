//
//  WJMsgCellData.h
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/3.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJMsgCellData : NSObject
@property (nonatomic,copy) NSString * content;
@property (nonatomic,copy) NSString * iconImg;
@property (nonatomic,copy) NSString * name;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)msgCellWithDic:(NSDictionary *)dic;

@end
