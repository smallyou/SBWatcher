//
//  SBScanTableController.m
//  SBWatcher
//
//  Created by 23 on 2017/7/30.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import "SBScanTableController.h"
#import "SBSqliteManager.h"
#import "SBTableItem.h"
#import "SBTableInfoItem.h"
#import "SBScanDataController.h"

@interface SBScanTableController () <UITableViewDelegate, UITableViewDataSource>

/**tableView*/
@property(nonatomic,weak) UITableView *tableView;

/**数据*/
@property(nonatomic,strong) NSMutableArray *datas;

/**当前选中的字段名称*/
@property(nonatomic,strong) NSMutableArray *selectedKeys;

@end

@implementation SBScanTableController

static NSString * const ID = @"info";

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
    self.title = self.tableItem.tbl_name;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"查看" style:UIBarButtonItemStyleDone target:self action:@selector(scanTable)];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsMultipleSelection = YES;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}


#pragma mark - 数据处理
/**加载数据*/
- (void)loadData
{
    NSArray *arrayM = [[SBSqliteManager shareManager] tableInfoAtTable:self.tableItem.tbl_name];
    
    self.datas = [NSMutableArray arrayWithArray:arrayM];
    
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource\UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    //取出模型
    SBTableInfoItem *item = self.datas[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@   %@",item.name,item.type];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"primary key:%d   not null:%d  defalut:%@",item.pk,item.notnull,item.dflt_value];
    
    return cell;
}

/**选中*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //取出模型
    SBTableInfoItem *item = self.datas[indexPath.row];
    
    if (![self.selectedKeys containsObject:item]) {
        [self.selectedKeys addObject:item];
    }
}

/**未选中*/
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBTableInfoItem *item = self.datas[indexPath.row];
    if ([self.selectedKeys containsObject:item]) {
        [self.selectedKeys removeObject:item];
    }
}



#pragma mark - 事件响应
/**查看数据表*/
- (void)scanTable
{
    SBScanDataController *vc = [[SBScanDataController alloc ] init];
    vc.title = self.title;
    
    NSString *sql = @"";
    if (self.selectedKeys.count == 0) {
        sql = [NSString stringWithFormat:@"select * from %@",self.tableItem.tbl_name];
        vc.sql = sql;
        vc.datas = [[SBSqliteManager shareManager] rowsWithSelectSql:sql];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    //遍历
    SBTableInfoItem *first = self.selectedKeys.firstObject;
    NSString *key = [first name];
    for (int i = 1; i < self.selectedKeys.count; i++) {
        SBTableInfoItem *item = self.selectedKeys[i];
        key = [NSString stringWithFormat:@"%@,%@",key,item.name];
    }
    
    sql = [NSString stringWithFormat:@"select %@ from %@",key,self.tableItem.tbl_name];
    vc.sql = sql;
    vc.datas = [[SBSqliteManager shareManager] rowsWithSelectSql:sql];
    
    [self.navigationController pushViewController:vc animated:YES];

}


#pragma mark - 懒加载
- (NSMutableArray *)datas
{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (NSMutableArray *)selectedKeys
{
    if (_selectedKeys == nil) {
        _selectedKeys = [NSMutableArray array];
    }
    return _selectedKeys;
}

@end
