//
//  JSStatisticalDataManager.m
//  CountApp
//
//  Created by stefanie on 16/6/12.
//  Copyright © 2016年 Stefanie. All rights reserved.
//

#import "JSStatisticalDataManager.h"

#import "JSUPLoad.h"

#define PAGENOW_DIRECTORY [NSString stringWithFormat:@"%@/%@/%@/", NSHomeDirectory(), @"Library", @"logCache/pagenow"]
#define PAGEM5_DIRECTORY [NSString stringWithFormat:@"%@/%@/%@/", NSHomeDirectory(), @"Library", @"logCache/pagem5"]
#define PAGEH1_DIRECTORY [NSString stringWithFormat:@"%@/%@/%@/", NSHomeDirectory(), @"Library", @"logCache/pageh1"]
#define PAGED1_DIRECTORY [NSString stringWithFormat:@"%@/%@/%@/", NSHomeDirectory(), @"Library", @"logCache/paged1"]
#define EVENTNOW_DIRECTORY [NSString stringWithFormat:@"%@/%@/%@/", NSHomeDirectory(), @"Library", @"logCache/eventnow"]
#define EVENTM5_DIRECTORY [NSString stringWithFormat:@"%@/%@/%@/", NSHomeDirectory(), @"Library", @"logCache/eventm5"]
#define EVENTH1_DIRECTORY [NSString stringWithFormat:@"%@/%@/%@/", NSHomeDirectory(), @"Library", @"logCache/eventh1"]
#define EVENTD1_DIRECTORY [NSString stringWithFormat:@"%@/%@/%@/", NSHomeDirectory(), @"Library", @"logCache/eventd1"]


@implementation JSStatisticalDataManager

+ (void)initDirectorys {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directorys = @[PAGENOW_DIRECTORY, PAGEM5_DIRECTORY, PAGEH1_DIRECTORY, PAGED1_DIRECTORY, EVENTNOW_DIRECTORY, EVENTM5_DIRECTORY, EVENTH1_DIRECTORY, EVENTD1_DIRECTORY];
    NSArray *fileNames = @[@"nowpage.txt", @"m5page.txt", @"h1page.txt", @"d1page.txt", @"nowevent.txt", @"m5event.txt", @"h1event.txt", @"d1event.txt"];
    for (NSInteger i = 0; i < directorys.count; i++) {
        NSString *directory = directorys[i];
        if(![fileManager fileExistsAtPath:directory]){
            NSError __autoreleasing *error = nil;
            [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error];
        }
        // 如果文件夹中文件为空 创建一个空的文本文件保存
        NSLog(@"%zd", [fileManager contentsOfDirectoryAtPath:directory error:nil].count);
        if ([fileManager contentsOfDirectoryAtPath:directory error:nil].count == 0) {
            NSDate *date = [NSDate date];
            NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
            dataFormatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *timeString = [dataFormatter stringFromDate:date];
            NSString *logStr = [directory stringByAppendingString:[timeString stringByAppendingString:fileNames[i]]];
            [fileManager createFileAtPath:logStr contents:nil attributes:nil];
//            [JSClick enterPageView:@"ViewController" timeType:M5_DATA];
//            [JSClick leavePageView:@"ViewController" timeType:M5_DATA];
        }
    }
}

+ (void)dealCacheString:(NSString *)cacheString dataType:(DATA_TYPE)dataType timeType:(TIME_TYPE)timeType {
    
    // 读取不到配对的页面或者事件  return  不记录
    NSArray *arr = [cacheString componentsSeparatedByString:@","];
    if ([arr[4] isEqual:@"(null)"]) {
        return;
    }
    
    if (dataType == PAGE_STATISYICAL) {
        switch (timeType) {
            case NOW_DATA:
                [self writeLog:cacheString ToPath:PAGENOW_DIRECTORY];
                break;
            case M5_DATA:
                [self writeLog:cacheString ToPath:PAGEM5_DIRECTORY];
                break;
            case H1_DATA:
                [self writeLog:cacheString ToPath:PAGEH1_DIRECTORY];
                break;
            case D1_DATA:
                [self writeLog:cacheString ToPath:PAGED1_DIRECTORY];
                break;
                
            default:
                break;
        }
    }
    
    if (dataType == EVENT_STATISYICAL) {
        switch (timeType) {
            case NOW_DATA:
                [self writeLog:cacheString ToPath:EVENTNOW_DIRECTORY];
                break;
            case M5_DATA:
                [self writeLog:cacheString ToPath:EVENTM5_DIRECTORY];
                break;
            case H1_DATA:
                [self writeLog:cacheString ToPath:EVENTH1_DIRECTORY];
                break;
            case D1_DATA:
                [self writeLog:cacheString ToPath:EVENTD1_DIRECTORY];
                break;
                
            default:
                break;
        }
    }
    
    NSLog(@"%@", cacheString);
}


// 存储记录到文件
+ (void)writeLog:(NSString *)cacheString ToPath:(NSString *)path {
    NSString *writePath = [NSString stringWithFormat:@"%@/%@",path, [self getNearestTimeTagWithPath:path]];
    NSFileHandle *fielHandle = [NSFileHandle fileHandleForUpdatingAtPath:writePath];
    [fielHandle seekToEndOfFile];  // 将节点跳到文件的末尾
    [fielHandle writeData:[cacheString dataUsingEncoding:NSUTF8StringEncoding]];
}


+ (void)uploadLogDataType:(DATA_TYPE)dataType timeType:(TIME_TYPE)timeType {
    if (dataType == PAGE_STATISYICAL) {
        switch (timeType) {
            case NOW_DATA:
                break;
            case M5_DATA:
                [self uploadAllFileWithDirectory:PAGEM5_DIRECTORY];
                break;
            case H1_DATA:
                [self uploadAllFileWithDirectory:PAGEH1_DIRECTORY];
                break;
            case D1_DATA:
                [self uploadAllFileWithDirectory:PAGED1_DIRECTORY];
                break;
                
            default:
                break;
        }
    }
    if (dataType == EVENT_STATISYICAL) {
        switch (timeType) {
            case NOW_DATA:
                break;
            case M5_DATA:
                [self uploadAllFileWithDirectory:EVENTM5_DIRECTORY];
                break;
            case H1_DATA:
                [self uploadAllFileWithDirectory:EVENTH1_DIRECTORY];
                break;
            case D1_DATA:
                [self uploadAllFileWithDirectory:EVENTD1_DIRECTORY];
                break;
                
            default:
                break;
        }
    }
}

// 上传一个文件夹中的所有文件
+ (void)uploadAllFileWithDirectory:(NSString *)directory {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *fileList = [fm contentsOfDirectoryAtPath:directory error:nil];
    for (NSString *filePath in fileList) {
        [JSUPLoad uploadWithPath:[NSString stringWithFormat:@"%@/%@",directory, filePath]];
    }
}


+ (void)samplingIntervalCreatCacheFileTimeType:(TIME_TYPE)timeType {
    NSDate *date = [NSDate date];
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    dataFormatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *timeString = [dataFormatter stringFromDate:date];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    switch (timeType) {
        case M5_DATA:
        {
            // 创建五分钟文件
            NSString *cachePath1 = [NSString stringWithFormat:@"%@/%@m5page.txt", PAGEM5_DIRECTORY, timeString];
            NSString *cachePath2 = [NSString stringWithFormat:@"%@/%@m5evevt.txt", EVENTM5_DIRECTORY, timeString];
            [fileManager createFileAtPath:cachePath1 contents:nil attributes:nil];
            [fileManager createFileAtPath:cachePath2 contents:nil attributes:nil];
        }
            break;
        case H1_DATA:
        {
            // 创建一小时文件
            NSString *cachePath1 = [NSString stringWithFormat:@"%@/%@h1page.txt", PAGEH1_DIRECTORY, timeString];
            NSString *cachePath2 = [NSString stringWithFormat:@"%@/%@h1evevt.txt", EVENTH1_DIRECTORY, timeString];
            [fileManager createFileAtPath:cachePath1 contents:nil attributes:nil];
            [fileManager createFileAtPath:cachePath2 contents:nil attributes:nil];
        }
        case D1_DATA:
        {
            // 创建一天文件
            NSString *cachePath1 = [NSString stringWithFormat:@"%@/%@d1page.txt", PAGED1_DIRECTORY, timeString];
            NSString *cachePath2 = [NSString stringWithFormat:@"%@/%@d1evevt.txt", EVENTD1_DIRECTORY, timeString];
            [fileManager createFileAtPath:cachePath1 contents:nil attributes:nil];
            [fileManager createFileAtPath:cachePath2 contents:nil attributes:nil];
        }
        default:
            break;
    }
}


// 取出一个文件夹中最近时间点的文件
+ (NSString *)getNearestTimeTagWithPath:(NSString *)cachePath {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *fileList = [fm contentsOfDirectoryAtPath:cachePath error:nil];
    return [fileList lastObject];
}


@end
