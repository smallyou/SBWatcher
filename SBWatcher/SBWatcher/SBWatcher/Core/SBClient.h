//
//  SBClient.h
//  SBWatcher
//
//  Created by 23 on 2017/7/24.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBClient : NSObject


/**
 获取字符串的MD5值

 @param str 字符串
 @return md5
 */
+ (NSString *)md5EncodeFromStr:(NSString *)str;

@end
