//
//  JSPageManager.h
//  CountApp
//
//  Created by stefanie on 16/6/12.
//  Copyright © 2016年 Stefanie. All rights reserved.
//  ＊＊＊＊＊页面统计类 负责收集到页面统计信息后 整理信息＊＊＊＊＊

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, StatisticsType) {
    PlayPageDuration,                       // 统计播放页面播放时长
};

@interface JSPageManager : NSObject

/**
 *  统计类总方法
 *
 *  @param controllName   控制器的名字
 *  @param timestamp      执行该的时间戳
 *  @param statisticsType 统计页面的类型
 *  @param yesOrNo        进入页面或者退出页面 yes是进入 no是退出
 */
+ (void)StatisticsControllerWithController:(NSString *)controllName timestamp:(long)timestamp statisticsType:(StatisticsType)statisticsType beginOrEnd:(BOOL)yesOrNo;

@end
