//
//  JSClickEventStat.h
//  CountApp
//
//  Created by stefanie on 16/6/14.
//  Copyright © 2016年 Stefanie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSClick.h"

typedef void(^cacheString)(NSString *cacheString);

@interface JSClickEventStat : NSObject

+ (void)clickEvent:(NSString *)enentName timeType:(TIME_TYPE)timeType cacheString:(cacheString)cacheStr;

@end
