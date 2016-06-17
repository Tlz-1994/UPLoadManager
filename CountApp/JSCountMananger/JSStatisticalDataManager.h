//
//  JSStatisticalDataManager.h
//  CountApp
//
//  Created by stefanie on 16/6/12.
//  Copyright © 2016年 Stefanie. All rights reserved.
//  ＊＊＊＊＊负责统计数据处理的类 将统计的数据整合＊＊＊＊＊

#import <Foundation/Foundation.h>
#import "JSClick.h"

@interface JSStatisticalDataManager : NSObject

/**
 *  初始化储存目录
 */
+ (void)initDirectorys;

/**
 *  间隔创建缓存文件
 */
+ (void)samplingIntervalCreatCacheFileTimeType:(TIME_TYPE)timeType;

/**
 *  间隔上传文件
 *
 */
+ (void)uploadLogDataType:(DATA_TYPE)dataType timeType:(TIME_TYPE)timeType;

/**
 *  根据不同的类型进行不同的存储操作
 *
 *  @param cacheString 需存储的单条日志
 *  @param dataType    记录的数据类型
 *  @param timeType    记录的时间类型
 */
+ (void)dealCacheString:(NSString *)cacheString dataType:(DATA_TYPE)dataType timeType:(TIME_TYPE)timeType;

@end
