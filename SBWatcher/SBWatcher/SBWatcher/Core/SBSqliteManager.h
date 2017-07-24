//
//  SBSqliteManager.h
//  SBWatcher
//
//  Created by 23 on 2017/7/22.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBSqliteManager : NSObject

+ (instancetype)shareManager;



/**
 获取指定路径数据库的数据表

 @param path 数据库路径
 @return 数据表集合
 */
- (NSArray *)tablesInDatabaseAtPath:(NSString *)path;

@end
