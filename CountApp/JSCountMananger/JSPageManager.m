//
//  JSPageManager.m
//  CountApp
//
//  Created by stefanie on 16/6/12.
//  Copyright © 2016年 Stefanie. All rights reserved.
//  

#import "JSPageManager.h"
#import "JSStatisticalDataManager.h"

static NSString *cacheString = nil;       // 中间缓存用的字符串

@implementation JSPageManager

+ (void)StatisticsControllerWithController:(NSString *)controllName timestamp:(long)timestamp statisticsType:(StatisticsType)statisticsType beginOrEnd:(BOOL)yesOrNo {
    yesOrNo ? [self BeginStatisticsControllerWithController:controllName timestamp:timestamp statisticsType:statisticsType]: [self EndStatisticsControllerWithController:controllName timestamp:timestamp statisticsType:statisticsType];
}

// 进入页面对应的方法
+ (void)BeginStatisticsControllerWithController:(NSString *)controllName timestamp:(long)timestamp statisticsType:(StatisticsType)statisticsType {
    switch (statisticsType) {
        case PlayPageDuration:
            [self PlayPageDurationBeginStatisticsControllerWithController:controllName timestamp:timestamp];
            break;
            
        default:
            break;
    }
}

// 退出页面对应的方法
+ (void)EndStatisticsControllerWithController:(NSString *)controllName timestamp:(long)timestamp statisticsType:(StatisticsType)statisticsType {
    switch (statisticsType) {
        case PlayPageDuration:
            [self PlayPageDurationEndStatisticsControllerWithController:controllName timestamp:timestamp];
            break;
            
        default:
            break;
    }
}

#pragma mark - 根据不同的统计类型分别处理
// 统计播放时长
+ (void)PlayPageDurationBeginStatisticsControllerWithController:(NSString *)controllName timestamp:(long)timestamp {
    // 根据控制器名字拿到该控制器对应的事先约定好的pageid  该数据放在plist文件中
    NSDictionary *pageNameList = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PageName" ofType:@"plist"]];
    NSString *pageID = [pageNameList valueForKey:controllName];

    cacheString = [NSString stringWithFormat:@"%@->%@->%ld", @"uid", pageID, timestamp];
//    NSLog(@"%@", cacheString);
}

+ (void)PlayPageDurationEndStatisticsControllerWithController:(NSString *)controllName timestamp:(long)timestamp {
    // 根据控制器名字拿到该控制器对应的事先约定好的pageid  该数据放在plist文件中
//    NSDictionary *pageNameList = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PageName" ofType:@"plist"]];
//    NSString *pageID = [pageNameList valueForKey:controllName];
    
    cacheString = [cacheString stringByAppendingString:[NSString stringWithFormat:@"->%ld", timestamp]];
    NSLog(@"%@", cacheString);
//    [JSStatisticalDataManager saveCacheLogWithCacheString:cacheString];
}

@end
