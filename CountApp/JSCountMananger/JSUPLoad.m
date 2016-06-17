//
//  JSUPLoad.m
//  CountApp
//
//  Created by stefanie on 16/6/16.
//  Copyright © 2016年 Stefanie. All rights reserved.
//

#define QNtoken @"iN7NgwM31j4-BZacMjPrOQBs34UG1maYCAQmhdCV:fjSkz5yohmoARYHhaDN2tIgajfU=:eyJzY29wZSI6InF0ZXN0YnVja2V0IiwiZGVhZGxpbmUiOjE0NTg2MzEzNTh9"
#import "JSUPLoad.h"

#import <QiniuSDK.h>
#include <CommonCrypto/CommonCrypto.h>
#import <AFNetworking.h>
#import "QN_GTM_Base64.h"
#import "JSONKit.h"

@implementation JSUPLoad

+ (void)uploadWithPath:(NSString *)path {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    QNUploadManager *QNManager = [[QNUploadManager alloc] init];
    [QNManager putFile:path key:path token:@"Xw0U1GcFYDsww8rlKGIYiHPtKxTaZ0PrJGQ6LFc7:O-FO15CyvNLTCN9_ChR5JNQuiEY=:eyJzY29wZSI6ImppYW9zaGkiLCJkZWFkbGluZSI6MTQ2NjA3Mjk0M30=" complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@"%@",info);
        if (info) {
            [manager removeItemAtPath:path error:nil];
        }
    } option:nil];
}

+ (NSString *)makeToken:(NSString *)accessKey secretKey:(NSString *)secretKey
{
    const char *secretKeyStr = [secretKey UTF8String];
    
    NSString *policy = [self marshal];
    
    NSData *policyData = [policy dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *encodedPolicy = [QN_GTM_Base64 stringByWebSafeEncodingData:policyData padded:TRUE];
    const char *encodedPolicyStr = [encodedPolicy cStringUsingEncoding:NSUTF8StringEncoding];
    
    char digestStr[CC_SHA1_DIGEST_LENGTH];
    bzero(digestStr, 0);
    
    CCHmac(kCCHmacAlgSHA1, secretKeyStr, strlen(secretKeyStr), encodedPolicyStr, strlen(encodedPolicyStr), digestStr);
    
    NSString *encodedDigest = [QN_GTM_Base64 stringByWebSafeEncodingBytes:digestStr length:CC_SHA1_DIGEST_LENGTH padded:TRUE];
    
    NSString *token = [NSString stringWithFormat:@"%@:%@:%@",  accessKey, encodedDigest, encodedPolicy];
    
    return token;//得到了token
}
static NSInteger expires;
+ (NSString *)marshal
{
    time_t deadline;
    time(&deadline);//返回当前系统时间
    //@property (nonatomic , assign) int expires; 怎么定义随你...
    deadline += (expires > 0) ? expires : 3600; // +3600秒,即默认token保存1小时.
    
    NSNumber *deadlineNumber = [NSNumber numberWithLongLong:deadline];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //users是我开辟的公共空间名（即bucket），aaa是文件的key，
    //按七牛“上传策略”的描述：    <bucket>:<key>，表示只允许用户上传指定key的文件。在这种格式下文件默认允许“修改”，若已存在同名资源则会被覆盖。如果只希望上传指定key的文件，并且不允许修改，那么可以将下面的 insertOnly 属性值设为 1。
    //所以如果参数只传users的话，下次上传key还是aaa的文件会提示存在同名文件，不能上传。
    //传users:aaa的话，可以覆盖更新，但实测延迟较长，我上传同名新文件上去，下载下来的还是老文件。
    [dic setObject:@"users:aaa" forKey:@"scope"];//根据
    
    [dic setObject:deadlineNumber forKey:@"deadline"];
    
    NSString *json = [dic JSONString];
    
    return json;
}

@end
