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
    
    //便利当前行的所有字段(列)
    for (int i = 0; i < columnCount; i++) {
        
        //获取当前的列表（字段名）
        char *columnName = columnNames[i];
        NSString *nameStr = [NSString stringWithUTF8String:columnName];
        
        //获取当前字段的值
        char *columnValue = columnValues[i];
        NSString *valueStr = [NSString stringWithUTF8String:columnValue];
        
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



#pragma mark - 懒加载
- (NSMutableArray *)results
{
    if (_results == nil) {
        _results = [NSMutableArray array];
    }
    return _results;
}

@end
