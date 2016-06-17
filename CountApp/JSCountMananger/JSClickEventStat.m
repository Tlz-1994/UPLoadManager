//
//  JSClickEventStat.m
//  CountApp
//
//  Created by stefanie on 16/6/14.
//  Copyright © 2016年 Stefanie. All rights reserved.
//

#import "JSClickEventStat.h"

@implementation JSClickEventStat

+ (void)clickEvent:(NSString *)enentName timeType:(TIME_TYPE)timeType cacheString:(cacheString)cacheStr {
    NSDictionary *EventNameList = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PageName" ofType:@"plist"]];
    NSString *eventID = [EventNameList valueForKey:enentName];
    NSString *cacheString = nil;
    cacheString = [NSString stringWithFormat:@"%@,%@,%ld", @"uid", eventID, time(NULL)];
    cacheStr ? cacheStr(cacheString): nil;
}

@end
