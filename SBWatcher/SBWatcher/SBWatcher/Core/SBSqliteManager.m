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
    NSMutableArray *arrayM = [NSMutableArray array];
    
    //将当前的数据库文件赋值到tmp文件夹下
    self.currentDBPath = [self sb_copyDatabaseAtPath:path];
    
    //打开数据库
    sqlite3 *db = [self openDatabaseAtPath:self.currentDBPath];
    if (db == nil) {
        return arrayM;
    }
    
    //查询sqlite_master表
    NSString *sql = @"select * from t_student";
    
    //常见预处理语句
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil) != SQLITE_OK){
        //print("预处理失败")
        return arrayM;
    }
    
    // 绑定 - 如果没有需要绑定的参数，可以省略
    // 执行预处理语句 -- 每执行一次就是一行数据，每行记录（结果集）都放在stmt中
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        
        //创建模型
        SBTableItem *item = [[SBTableItem alloc] init];
        
        // 获取当前行有多少列(字段)
        int columnCount = sqlite3_column_count(stmt);
        
        // 循环取出字段
        for (int i = 0; i < columnCount; i++) {
            
            
            // 获取当前字段的字段名称(当前索引，第几个字段)
            const char * columnName = sqlite3_column_name(stmt, i);
            NSString *columnNameStr = [NSString stringWithCString:columnName encoding:NSUTF8StringEncoding];
            
            // 获取当前字段的类型
            int type = sqlite3_column_type(stmt, i);
            // 根据类型取出对应类型的值
            if (type == SQLITE_TEXT) { //如果是文本类型
                
                const unsigned char * value = sqlite3_column_text(stmt, i);
                NSString *valueStr = [NSString stringWithCString:value encoding:NSUTF8StringEncoding];
                
                [item setValue:valueStr forKeyPath:columnNameStr];

            }else if (type == SQLITE_INTEGER){ //如果是整型
                int value = sqlite3_column_int(stmt, i);
                
                
            }else if (type == SQLITE_FLOAT) { //如果是浮点型
                double value = sqlite3_column_double(stmt, i);
                
                
            }
            
        }
        
        [arrayM addObject:item];
    }
    
    
    return arrayM;
}

int callback(void *firstValue,int columnCount, char **columnValues, char **columnNames)
{
    NSLog(@"");
    
    return 0;
}



#pragma mark - 数据库操作工具方法
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


@end
