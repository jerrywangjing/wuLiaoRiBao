//
//  NSString+WJExtension.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/29.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "NSString+WJExtension.h"

@implementation NSString (WJExtension)

-(NSInteger)calculateFileSize{
    
    // 创建文件管理器
    NSFileManager * mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL dir = NO; // 是否为文件夹
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];
    if (exists == NO) {
        return 0; // 文件夹不存在
    }
    if (dir) { // self 是一个文件夹路径
        // 遍历文件夹里面的所有内容
        NSArray * subPaths = [mgr subpathsAtPath:self];
        NSInteger totleBytesSize  = 0 ;// 存放总字节大小
        for (NSString * subPath in subPaths) {
            // 获取全路径
            NSString * fullSubPath = [self stringByAppendingPathComponent:subPath];
            // 判断是否为文件
            [mgr fileExistsAtPath:fullSubPath isDirectory:&dir];
            if (dir == NO) { // 是文件
                totleBytesSize += [[mgr attributesOfItemAtPath:fullSubPath error:nil][NSFileSize] integerValue];
            }
            //[subPath hasSuffix:@".mp4"]; // 判断文件路径后缀名是否是.mp4
        }
        return totleBytesSize;
    }else{ // self 是一个文件
        
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
    }
}

@end
