//
//  JSClickPageStat.h
//  CountApp
//
//  Created by stefanie on 16/6/14.
//  Copyright © 2016年 Stefanie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSClick.h"

typedef void(^cacheString)(NSString *cacheString);

@interface JSClickPageStat : NSObject

+ (void)enterPageView:(NSString *)pageName timeType:(TIME_TYPE)timeType;

+ (void)leavePageView:(NSString *)pageName pageType:(NSString *)pageType objectid:(NSString *)objectid timeType:(TIME_TYPE)timeType cacheString:(cacheString)cacheStr;


@end
