//
//  SBScanDBController.m
//  SBWatcher
//
//  Created by 23 on 2017/7/24.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import "SBScanDBController.h"
#import "SBSqliteManager.h"
#import "SBTableItem.h"

@interface SBScanDBController () <UITableViewDelegate,UITableViewDataSource>

/***/
@property(nonatomic,weak) UITableView *tableView;

/***/
@property(nonatomic,strong) NSMutableArray *datas;

@end

@implementation SBScanDBController

static NSString * const ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置UI
    [self setupUI];
    
    //获取数据库中的数据表
    [self loadTable];
    
}

#pragma mark - 设置UI
- (void)setupUI
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:ID];
    tableView.frame = self.view.bounds;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

#pragma mark - UITableViewDataSource\UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    SBTableItem *item = self.datas[indexPath.row];
    cell.textLabel.text = item.tableName;
    return cell;
}

#pragma mark - 数据处理
/**获取数据库中的数据表*/
- (void)loadTable
{
    self.datas = [NSMutableArray arrayWithArray:[[SBSqliteManager shareManager] tablesInDatabaseAtPath:self.dbFullPath]];
    
    [self.tableView reloadData];
}


#pragma mark - 懒加载
- (NSMutableArray *)datas
{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}


@end
