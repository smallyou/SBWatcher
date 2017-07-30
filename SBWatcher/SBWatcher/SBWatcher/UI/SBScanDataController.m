//
//  SBScanDataController.m
//  SBWatcher
//
//  Created by 23 on 2017/7/30.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import "SBScanDataController.h"
#import "SBSqliteManager.h"

@interface SBScanDataController ()

@end

@implementation SBScanDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置UI
    [self setupUI];
    
    //加载数据
    [self loadData];
    
}

#pragma mark - 设置UI
/**设置UI*/
- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - 加载数据
- (void)loadData
{
    NSArray *arrayM = [[SBSqliteManager shareManager] rowsWithSelectSql:self.sql];
    NSLog(@"%@",arrayM);
}

@end
