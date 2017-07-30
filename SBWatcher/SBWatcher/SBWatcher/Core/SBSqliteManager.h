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


/**
 获取指定数据表的字段信息

 @param tableName 数据表名称
 @return 数据表字段信息集合
 */
- (NSArray *)tableInfoAtTable:(NSString *)tableName;


/**
 根据查询语句获取数据表中的数据记录集合

 @param sql sql语句
 @return 记录集合
 */
- (NSArray *)rowsWithSelectSql:(NSString *)sql;

@end
