//
//  JSStatisticsManager.m
//  CountApp
//
//  Created by stefanie on 16/6/12.
//  Copyright © 2016年 Stefanie. All rights reserved.
//

#import "JSStatisticsManager.h"

#import "JSPageManager.h"

static JSStatisticsManager *manager;

@implementation JSStatisticsManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    if (!manager) {
        dispatch_once(&onceToken, ^{
            manager = [[JSStatisticsManager alloc] init];
        });
    }
    return manager;
}

#pragma mark -统计页面时长
// 开始统计
+ (void)beginStatisticsVideoPlayDurationWithController:(NSString *)controllerName {
    long point_in_time = time(NULL);
    [JSPageManager StatisticsControllerWithController:controllerName timestamp:point_in_time statisticsType:PlayPageDuration beginOrEnd:YES];
}

// 结束统计
+ (void)endStatisticsVideoPlayDurationWithController:(NSString *)controllerName {
    long point_in_time = time(NULL);
    [JSPageManager StatisticsControllerWithController:controllerName timestamp:point_in_time statisticsType:PlayPageDuration beginOrEnd:NO];
}

@end
