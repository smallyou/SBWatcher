//
//  ViewController.m
//  SBWatcher
//
//  Created by 23 on 2017/7/22.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import "ViewController.h"
#import "SBWatcherHeader.h"
#import <sqlite3.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[SBWatcherManager shareManager] registWatcher];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSString *content = @"lasjlfjaslkfjlkasjflkasjflksajfljsalfjaslfjlskjfklsdj";
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    BOOL result = [[NSFileManager defaultManager] createFileAtPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"haha.html"] contents:data attributes:nil];
    
    
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingPathComponent:@"myDemo.db"];
    
    const char *filename = [path UTF8String];
    
    sqlite3 *db = nil;
    
    if(sqlite3_open(filename, &db) == SQLITE_OK){
        //成功打开数据库
        NSLog(@"成功打开数据库");
    }
    
    NSString *sql = @"create table if not exists t_student(id integer primary key autoincrement,student_id text unique,name text,age integer,time double)";
    if(sqlite3_exec(db, [sql UTF8String], nil, nil, nil)){
        //创建数据表成功
        NSLog(@"创建数据库表成功");
    }
    
    NSString *insertSql = @"insert into t_student values(NULL, 's_201007060224','chmn',24,123234343234234.99)";
    if(sqlite3_exec(db, [insertSql UTF8String], nil, nil, nil)){
        //插入语句成功
        NSLog(@"插入语句成功");
    }
    
    NSString *insertSql1 = @"insert into t_student values(NULL, 's_201007060223','chmn',24,123234343234234.99)";
    if(sqlite3_exec(db, [insertSql1 UTF8String], nil, nil, nil)){
        //插入语句成功
        NSLog(@"插入语句成功");
    }
    
    NSString *insertSql2 = @"insert into t_student values(NULL, 's_201007060222','chmn',24,123234343234234.99)";
    if(sqlite3_exec(db, [insertSql2 UTF8String], nil, nil, nil)){
        //插入语句成功
        NSLog(@"插入语句成功");
    }
    
    NSString *insertSql3 = @"insert into t_student values(NULL, 's_201007060221','chmn',24,123234343234234.99)";
    if(sqlite3_exec(db, [insertSql3 UTF8String], nil, nil, nil)){
        //插入语句成功
        NSLog(@"插入语句成功");
    }
    
    NSString *insertSql4 = @"insert into t_student values(NULL, 's_201007060220','chmn',24,123234343234234.99)";
    if(sqlite3_exec(db, [insertSql4 UTF8String], nil, nil, nil)){
        //插入语句成功
        NSLog(@"插入语句成功");
    }
    
    
    
    
    
    
    
    
    
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.title = @"other";
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
    
}


@end
