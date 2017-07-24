//
//  SBClient.m
//  SBWatcher
//
//  Created by 23 on 2017/7/24.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import "SBClient.h"
#import <CommonCrypto/CommonDigest.h>


@implementation SBClient

/**获取字符串的MD5值*/
+ (NSString *)md5EncodeFromStr:(NSString *)str {
    if (str.length == 0) {
        return nil;
    }
    // 初始化C字符数组
    const char* original_str = (const char *)[[str dataUsingEncoding:NSUTF8StringEncoding] bytes];
    // 盛放数字校验的字符数组（长度为16bytes）
    unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
    CC_MD5(original_str, (uint)strlen(original_str), digist);
    //        NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
    NSMutableString* outPutStr = [NSMutableString new];
    for(int  i =0; i<CC_MD5_DIGEST_LENGTH;i++){
        [outPutStr appendFormat:@"%02x",digist[i]];//小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
    }
    NSLog(@"outPutStr=========%@",outPutStr);
    return outPutStr;
}

@end
