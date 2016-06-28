//
//  JSClick.h
//  CountApp
//
//  Created by stefanie on 16/6/13.
//  Copyright © 2016年 Stefanie. All rights reserved.
//  ＊＊＊＊＊＊＊＊  用户统计功能接口调用类  ＊＊＊＊＊＊＊＊＊

#import <Foundation/Foundation.h>
// 上报的时间类型
typedef NS_ENUM(NSUInteger, TIME_TYPE) {
    NOW_DATA        = 0,        // 实时上报数据
    M5_DATA         = 1,        // 五分钟数据
    H1_DATA         = 2,        // 一小时数据
    D1_DATA         = 3,        // 一天数据
};

// 上报的数据类型
typedef NS_ENUM(NSUInteger, DATA_TYPE) {
    PAGE_STATISYICAL          = 0,        //
    EVENT_STATISYICAL         = 1,        //
};

@interface JSClickInstance : NSObject

@property (nonatomic, copy) NSString *nowCache;

@property (nonatomic, copy) NSString *m5Cache;

@property (nonatomic, copy) NSString *h1Cache;

@property (nonatomic, copy) NSString *d1Cache;

+ (instancetype)sharedInstance;

@end


@interface JSClick : NSObject

#pragma mark -
+ (void)starLogService;

#pragma maek 数据上报方法
+ (void)reportStatisticalWithDataType:(DATA_TYPE)dataType timeType:(TIME_TYPE)timeType statisticalData:(NSString *)oneLog;

#pragma mark 页面统计
/**
 *  和leavePageView方法一起使用，配合plist文件，在plist文件中定义好页面的字典，根据页面的名字获得该页面对应的页面id
 *
 *  @param pageName 页面的名称
 *  @param timeType 上报时间类型
 */
+ (void)enterPageView:(NSString *)pageName timeType:(TIME_TYPE)timeType;
/**
 *  和enterPageView方法一起使用，配合plist文件，在plist文件中定义好页面的字典，根据页面的名字获得该页面对应的页面id
 *
 *  @param pageName 页面的名称
 *  @param timeType 上报时间类型
 */
+ (void)leavePageView:(NSString *)pageName timeType:(TIME_TYPE)timeType pageType:(NSString *)pageType objectid:(NSString *)objectid;


#pragma mark 事件统计
/**
 *  统计单独事件，配合plist文件使用，在plist文件中定义好事件的字典，根据事件的名字获得该事件对应的事件id
 *
 *  @param enentName 事件的名字
 */
+ (void)clickEvent:(NSString *)enentName timeType:(TIME_TYPE)timeType;



@end
