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
#import "SBScanTableController.h"

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
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];;
    }
    SBTableItem *item = self.datas[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"type:%@; name:%@",item.displayType,item.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"数据表:%@",item.tbl_name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //取出模型
    SBTableItem *item = self.datas[indexPath.row];
    
    if (item.itemType != SBTableItemTypeTable) {
        [self alertBoxWithTitle:@"提示" Text:@"索引不可查看"];
        return;
    }
    
    SBScanTableController *vc = [[SBScanTableController alloc] init];
    vc.tableItem = item;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 数据处理
/**获取数据库中的数据表*/
- (void)loadTable
{
    self.datas = [NSMutableArray arrayWithArray:[[SBSqliteManager shareManager] tablesInDatabaseAtPath:self.dbFullPath]];
    
    [self.tableView reloadData];
}

#pragma mark - 工具
/**告警提示框*/
- (void)alertBoxWithTitle:(NSString *)title Text:(NSString *)text
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:UIAlertControllerStyleAlert];
    [ac addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:ac animated:YES completion:nil];
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
