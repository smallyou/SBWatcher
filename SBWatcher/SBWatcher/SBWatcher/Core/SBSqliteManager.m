//
//  SBSqliteManager.m
//  SBWatcher
//
//  Created by 23 on 2017/7/22.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import "SBSqliteManager.h"
#import <sqlite3.h>
#import "SBClient.h"
#import "SBTableItem.h"
#import "SBTableInfoItem.h"



@interface SBSqliteManager ()

/**当前的数据库路径*/
@property(nonatomic,copy) NSString *currentDBPath;

/**当前的结果--结果集*/
@property(nonatomic,strong) NSMutableArray *results;

@end

@implementation SBSqliteManager

static id _instance;
+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

/**获取指定路径数据库的数据表*/
- (NSArray *)tablesInDatabaseAtPath:(NSString *)path
{
    
    //赋值
    self.currentDBPath = path;
    
    //打开数据库
    sqlite3 *db = [self openDatabaseAtPath:self.currentDBPath];
    if (db == nil) {
        return nil;
    }
    
    //查询sqlite_master表
    NSString *sql = @"select type, name, tbl_name from sqlite_master";

    //执行sql语句
    char *errmsg = nil;
    sqlite3_exec(db, [sql UTF8String], sqliteMasterCallback, nil, &errmsg);
    
    //处理数据
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self.results];
    [self.results removeAllObjects];
    
    //关闭数据库
    sqlite3_close(db);
    db = nil;
    
    return arrayM;
}

/**获取指定数据表的字段信息*/
- (NSArray *)tableInfoAtTable:(NSString *)tableName
{
    //打开数据库
    sqlite3 *db = [self openDatabaseAtPath:self.currentDBPath];
    if (db == nil) {
        return nil;
    }
    
    //查询指定数据表的所有字段信息
    NSString *sql = [NSString stringWithFormat:@"PRAGMA table_info('%@')",tableName];
    
    //执行sql语句
    char *errmsg = nil;
    sqlite3_exec(db, [sql UTF8String], tableInfoCallback, nil, &errmsg);
    
    //处理数据
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self.results];
    [self.results removeAllObjects];
 
    return arrayM;
}

/**根据查询语句获取数据表中的数据记录集合*/
- (NSArray *)rowsWithSelectSql:(NSString *)sql
{
    //打开数据库
    sqlite3 *db = [self openDatabaseAtPath:self.currentDBPath];
    
    //执行sql
    char *errmsg = nil;
    sqlite3_exec(db, [sql UTF8String], selectCallback, nil, &errmsg);
    
    //处理数据
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self.results];
    [self.results removeAllObjects];
    
    return arrayM;
}


#pragma mark - 数据库操作工具方法
/**打开数据库*/
- (sqlite3 *)openDatabaseAtPath:(NSString *)path
{
    //打开数据库
    sqlite3 *db = nil;
    sqlite3_open([self.currentDBPath UTF8String], &db);
    
    return db;
}


#pragma mark - 工具方法
/**将当前的数据库文件赋值到tmp文件夹下*/
- (NSString *)sb_copyDatabaseAtPath:(NSString *)path
{
    //获取文件名，包含后缀
    NSString *dbName = [path lastPathComponent];
    NSString *destPath = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
    destPath = [destPath stringByAppendingPathComponent:dbName];
    
    NSError *error = nil;
    [[NSFileManager defaultManager] copyItemAtPath:path toPath:destPath error:&error];
    
    if (error) {
        return nil;
    }
    
    return destPath;
}

/**查询sqlite_master表的操作回调*/
int sqliteMasterCallback(void *firstValue,int columnCount, char **columnValues, char **columnNames)
{
    
    SBTableItem *tableItem = [[SBTableItem alloc] init];
    
    //遍历当前行的所有字段(列)
    for (int i = 0; i < columnCount; i++) {
        
        //获取当前的列表（字段名）
        char *columnName = columnNames[i];
        NSString *nameStr = nil;
        if (columnName == NULL) {
            nameStr = nil;
        }else{
            nameStr = [NSString stringWithUTF8String:columnName];
        }
        
        //获取当前字段的值
        char *columnValue = columnValues[i];
        NSString *valueStr = nil;
        if (columnValue == NULL) {
            valueStr = nil;
        }else{
            valueStr = [NSString stringWithUTF8String:columnValue];
        }
        
        //type
        if ([nameStr isEqualToString:@"type"]) {
            tableItem.type =valueStr;
            if ([valueStr isEqualToString:@"table"]) {
                //数据表
                tableItem.itemType = SBTableItemTypeTable;
                tableItem.displayType = @"数据表";
            }
            if ([valueStr isEqualToString:@"index"]) {
                //索引
                tableItem.itemType = SBTableItemTypeIndex;
                tableItem.displayType = @"索引";
            }
        }
        
        //name
        if ([nameStr isEqualToString:@"name"]) {
            tableItem.name =valueStr;
        }
        
        //tbl_name
        if ([nameStr isEqualToString:@"tbl_name"]) {
            tableItem.tbl_name = valueStr;
        }
    }

    
    //添加结果
    [[(SBSqliteManager *)_instance results] addObject:tableItem];

    return 0;
}

/**查询指定数据表的所有字段信息的操作回调*/
int tableInfoCallback(void *firstValue,int columnCount, char **columnValues, char **columnNames)
{
    //创建模型
    SBTableInfoItem *item = [[SBTableInfoItem alloc] init];
    
    //遍历当前行的所有字段(列)
    for (int i = 0; i < columnCount; i++) {
        
        //获取当前的列表（字段名）
        char *columnName = columnNames[i];
        NSString *nameStr = nil;
        if (columnName == NULL) {
            nameStr = nil;
        }else{
            nameStr = [NSString stringWithUTF8String:columnName];
        }
        
        //获取当前字段的值
        char *columnValue = columnValues[i];
        NSString *valueStr = nil;
        if (columnValue == NULL) {
            valueStr = nil;
        }else{
            valueStr = [NSString stringWithUTF8String:columnValue];
        }
        
        if ([nameStr isEqualToString:@"cid"]) {
            item.cid = valueStr;
        }
        
        if ([nameStr isEqualToString:@"name"]) {
            item.name = valueStr;
        }
        
        if ([nameStr isEqualToString:@"type"]) {
            item.type = valueStr;
        }
        
        if ([nameStr isEqualToString:@"notnull"]) {
            item.notnull = [valueStr isEqualToString:@"0"]?NO:YES;
        }
        
        if ([nameStr isEqualToString:@"dflt_value"]) {
            item.dflt_value = valueStr;
        }
        
        if ([nameStr isEqualToString:@"pk"]) {
            item.pk = [valueStr isEqualToString:@"0"]?NO:YES;
        }
    }
    
    [[(SBSqliteManager *)_instance results] addObject:item];
    
    return 0;
}

/**根据指定的查询语句查询记录后的操作回调*/
int selectCallback(void *firstValue,int columnCount, char **columnValues, char **columnNames)
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    //遍历当前行的所有字段(列)
    for (int i = 0; i < columnCount; i++) {
        
        //获取当前的列表（字段名）
        char *columnName = columnNames[i];
        NSString *nameStr = nil;
        if (columnName == NULL) {
            nameStr = nil;
        }else{
            nameStr = [NSString stringWithUTF8String:columnName];
        }
        
        //获取当前字段的值
        char *columnValue = columnValues[i];
        NSString *valueStr = nil;
        if (columnValue == NULL) {
            valueStr = nil;
        }else{
            valueStr = [NSString stringWithUTF8String:columnValue];
        }
        
        [dict setValue:valueStr forKey:nameStr];
        
    }
    
    [[(SBSqliteManager *)_instance results] addObject:dict];
    
    return 0;
}



#pragma mark - 懒加载
- (NSMutableArray *)results
{
    if (_results == nil) {
        _results = [NSMutableArray array];
    }
    return _results;
}

@end
