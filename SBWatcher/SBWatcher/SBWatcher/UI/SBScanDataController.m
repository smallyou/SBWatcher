//
//  SBScanDataController.m
//  SBWatcher
//
//  Created by 23 on 2017/7/30.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import "SBScanDataController.h"
#import "SBSqliteManager.h"
#import "SBScanDataHeaderView.h"
#import "SBScanDataCell.h"
#import "SBDataDisplayView.h"

@interface SBScanDataController () <UITableViewDelegate,UITableViewDataSource,SBScanDataHeaderViewDelegate>


/**UIScrollView*/
@property(nonatomic,weak) UIScrollView *scrollView;
/**TableView*/
@property(nonatomic,weak) UITableView *tableView;
/**headerView*/
@property(nonatomic,weak) SBScanDataHeaderView *headerView;
/**displayView*/
@property(nonatomic,weak) SBDataDisplayView *displayView;

@end

@implementation SBScanDataController

static NSString * const ID = @"rows";

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置UI
    [self setupUI];

}

#pragma mark - 设置UI
/**设置UI*/
- (void)setupUI
{
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.bounces  = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    [self.scrollView addSubview:tableView];
    self.tableView = tableView;
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    if (self.datas.count) {
        NSDictionary *dict = self.datas.firstObject;
        NSUInteger num = [dict allKeys].count;
        self.tableView.frame = CGRectMake(0, 0, num * 200, self.scrollView.frame.size.height);
        self.scrollView.contentSize = CGSizeMake(self.tableView.frame.size.width, self.scrollView.bounds.size.height);
    }
    
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datas.count == 0?0:1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SBScanDataHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (headerView == nil) {
        headerView = [[SBScanDataHeaderView alloc] init];
    }
    
    NSDictionary *dict = self.datas.firstObject;
    headerView.titles = [dict allKeys];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBScanDataCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SBScanDataCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleView.delegate = self;
    }
    
    cell.titleView.type = (indexPath.row % 2 == 0)?SBScanDataHeaderViewTypeRowsOne:SBScanDataHeaderViewTypeRowsTwo;
    
    //取出数据
    NSDictionary *dict = self.datas[indexPath.row];
    
    cell.dictionary = dict;
    
    return cell;
}

#pragma mark - SBScanDataHeaderViewDelegate
/**点击具体的值，显示*/
- (void)headerView:(SBScanDataHeaderView *)headerView didLabelTaped:(UILabel *)label
{
    //取出当前点击的label的文字
    NSString *title = label.text;
    
    //显示
    [self showDisplayView:title];
}

/**显示displayView*/
- (void)showDisplayView:(NSString *)title
{
    if (self.displayView) {
        [self.displayView removeFromSuperview];
    }
    
    SBDataDisplayView *displayView = [[SBDataDisplayView alloc] initWithTitle:title];
    displayView.backgroundColor = [UIColor lightGrayColor];
    [[UIApplication sharedApplication].keyWindow addSubview:displayView];
    [displayView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDisplayView)]];
    self.displayView = displayView;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    displayView.frame = CGRectMake(0.5 * (width - 150), 0.5 * (height - 100), 150, 100);
    displayView.label.hidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        displayView.frame = CGRectMake(0.5 * (width - 300), 0.5 * (height - 200), 300, 200);
    }completion:^(BOOL finished) {
        displayView.label.hidden = NO;
    }];
}

- (void)dismissDisplayView
{
    if (self.displayView) {
        [self.displayView removeFromSuperview];
    }
}






@end
