//
//  JSClickPageStat.m
//  CountApp
//
//  Created by stefanie on 16/6/14.
//  Copyright © 2016年 Stefanie. All rights reserved.
//

#import "JSClickPageStat.h"

@implementation JSClickPageStat

+ (void)enterPageView:(NSString *)pageName timeType:(TIME_TYPE)timeType {
    // 根据控制器名字拿到该控制器对应的事先约定好的pageid  该数据放在plist文件中
    NSDictionary *pageNameList = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PageName" ofType:@"plist"]];
    NSString *pageID = [pageNameList valueForKey:pageName];
    NSString *cacheString = [NSString stringWithFormat:@"%@,%@,%ld,", @"uid", pageID, time(NULL)];
    switch (timeType) {
        case NOW_DATA:
            [JSClickInstance sharedInstance].nowCache = cacheString;
            break;
        case M5_DATA:
            [JSClickInstance sharedInstance].m5Cache = cacheString;
            break;
        case H1_DATA:
            [JSClickInstance sharedInstance].h1Cache = cacheString;
            break;
        case D1_DATA:
            [JSClickInstance sharedInstance].d1Cache = cacheString;
            break;
            
        default:
            break;
    }
}

+ (void)leavePageView:(NSString *)pageName timeType:(TIME_TYPE)timeType cacheString:(cacheString)cacheStr {
    NSString *cacheString = nil;
    switch (timeType) {
        case NOW_DATA:
            [JSClickInstance sharedInstance].nowCache = [NSString stringWithFormat:@"%@%ld\n", [JSClickInstance sharedInstance].nowCache, time(NULL)];
            cacheString = [JSClickInstance sharedInstance].nowCache;
            break;
        case M5_DATA:
            [JSClickInstance sharedInstance].m5Cache = [NSString stringWithFormat:@"%@%ld\n", [JSClickInstance sharedInstance].m5Cache, time(NULL)];
            cacheString = [JSClickInstance sharedInstance].m5Cache;
            break;
        case H1_DATA:
            [JSClickInstance sharedInstance].h1Cache = [NSString stringWithFormat:@"%@%ld\n", [JSClickInstance sharedInstance].h1Cache, time(NULL)];
            cacheString = [JSClickInstance sharedInstance].h1Cache;
            break;
        case D1_DATA:
            [JSClickInstance sharedInstance].d1Cache = [NSString stringWithFormat:@"%@%ld\n", [JSClickInstance sharedInstance].d1Cache, time(NULL)];
            cacheString = [JSClickInstance sharedInstance].d1Cache;
            break;
            
        default:
            break;
    }
    cacheStr ? cacheStr(cacheString): nil;
}


@end
