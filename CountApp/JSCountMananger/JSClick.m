//
//  JSClick.m
//  CountApp
//
//  Created by stefanie on 16/6/13.
//  Copyright © 2016年 Stefanie. All rights reserved.
//

#import "JSClick.h"
#import "JSClickPageStat.h"
#import "JSClickEventStat.h"
#import "JSStatisticalDataManager.h"

static NSString *const timePointM5 = @"timePointM5";
static NSString *const timePointH1 = @"timePointH1";
static NSString *const timePointD1 = @"timePointD1";

#define TIMEPOINT(P) [[[NSUserDefaults standardUserDefaults] valueForKey:P] integerValue]

#define STETIME(P) [[NSUserDefaults standardUserDefaults] setInteger:[[NSNumber numberWithLong:time(NULL)] integerValue] forKey:P]

@implementation JSClickInstance

static JSClickInstance *instanse = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    if (instanse == nil) {
        dispatch_once(&onceToken, ^{
            instanse = [[JSClickInstance alloc] init];
        });
    }
    return instanse;
}

@end


@implementation JSClick

+ (void)starLogService {
    // 初始化储存目录
    [JSStatisticalDataManager initDirectorys];
    // 初始化上传时间
    [self initTimeCache];
    NSTimer *timer = [NSTimer timerWithTimeInterval:30 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
}

+ (void)initTimeCache {
    [[NSUserDefaults standardUserDefaults] valueForKey:timePointM5] ? nil: [[NSUserDefaults standardUserDefaults] setInteger:[[NSNumber numberWithLong:time(NULL)] integerValue] forKey:timePointM5];
    [[NSUserDefaults standardUserDefaults] valueForKey:timePointH1] ? nil: [[NSUserDefaults standardUserDefaults] setInteger:[[NSNumber numberWithLong:time(NULL)] integerValue] forKey:timePointH1];
    [[NSUserDefaults standardUserDefaults] valueForKey:timePointD1] ? nil: [[NSUserDefaults standardUserDefaults] setInteger:[[NSNumber numberWithLong:time(NULL)] integerValue] forKey:timePointD1];
    
    NSLog(@"%@ \n %@\n %@", [[NSUserDefaults standardUserDefaults] valueForKey:@"timePointM5"], [[NSUserDefaults standardUserDefaults] valueForKey:@"timePointH1"], [[NSUserDefaults standardUserDefaults] valueForKey:@"timePointD1"]);
}

+ (void)timerAction {
    if (time(NULL) - TIMEPOINT(timePointM5) >= 30) {
        // 五分钟上传服务
        STETIME(timePointM5);
        NSLog(@"五分钟上传服务");
        [JSStatisticalDataManager uploadLogDataType:PAGE_STATISYICAL timeType:M5_DATA];
        [JSStatisticalDataManager uploadLogDataType:EVENT_STATISYICAL timeType:M5_DATA];
        [JSStatisticalDataManager samplingIntervalCreatCacheFileTimeType:M5_DATA];
    }
    if (time(NULL) - TIMEPOINT(timePointH1) >= 3600) {
        // 一小时上传服务
        STETIME(timePointH1);
        NSLog(@"一小时上传服务");
        [JSStatisticalDataManager uploadLogDataType:PAGE_STATISYICAL timeType:H1_DATA];
        [JSStatisticalDataManager uploadLogDataType:EVENT_STATISYICAL timeType:H1_DATA];
        [JSStatisticalDataManager samplingIntervalCreatCacheFileTimeType:H1_DATA];
    }
    if (time(NULL) - TIMEPOINT(timePointD1) >= 86400) {
        // 一天上传服务
        STETIME(timePointD1);
        NSLog(@"一天上传服务");
        [JSStatisticalDataManager uploadLogDataType:PAGE_STATISYICAL timeType:D1_DATA];
        [JSStatisticalDataManager uploadLogDataType:EVENT_STATISYICAL timeType:D1_DATA];
        [JSStatisticalDataManager samplingIntervalCreatCacheFileTimeType:D1_DATA];
    }
}


+ (void)reportStatisticalWithDataType:(DATA_TYPE)dataType timeType:(TIME_TYPE)timeType statisticalData:(NSString *)oneLog {
    [JSStatisticalDataManager dealCacheString:oneLog dataType:dataType timeType:timeType];
}


+ (void)enterPageView:(NSString *)pageName timeType:(TIME_TYPE)timeType {
    [JSClickPageStat enterPageView:pageName timeType:timeType];
}

+ (void)leavePageView:(NSString *)pageName timeType:(TIME_TYPE)timeType pageType:(NSString *)pageType objectid:(NSString *)objectid {
    __weak typeof(self) weakSelf = self;
    [JSClickPageStat leavePageView:pageName pageType:pageType objectid:objectid timeType:timeType cacheString:^(NSString *cacheString) {
        [weakSelf reportStatisticalWithDataType:PAGE_STATISYICAL timeType:timeType statisticalData:cacheString];
    }];
}



+ (void)clickEvent:(NSString *)enentName timeType:(TIME_TYPE)timeType {
    __weak typeof(self) weakSelf = self;
    [JSClickEventStat clickEvent:enentName timeType:timeType cacheString:^(NSString *cacheString) {
        [weakSelf reportStatisticalWithDataType:EVENT_STATISYICAL timeType:timeType statisticalData:cacheString];
    }];
}

@end
