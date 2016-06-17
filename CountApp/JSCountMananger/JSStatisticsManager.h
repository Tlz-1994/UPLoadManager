//
//  JSStatisticsManager.h
//  CountApp
//
//  Created by stefanie on 16/6/12.
//  Copyright © 2016年 Stefanie. All rights reserved.
//  ＊＊＊＊＊统计页面的类 负责纪录每个页面的独立信息＊＊＊＊＊

#import <Foundation/Foundation.h>

@interface JSStatisticsManager : NSObject

#pragma mark -统计页面时长
// 开始统计
+ (void)beginStatisticsVideoPlayDurationWithController:(NSString *)controllerName;

// 结束统计
+ (void)endStatisticsVideoPlayDurationWithController:(NSString *)controllerName;

#pragma mark - .....

@end
