//
//  SBMenuController.m
//  SBWatcher
//
//  Created by 23 on 2017/7/22.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import "SBMenuController.h"
#import "SBFileItem.h"
#import "SBWatcherManager.h"
#import "SBScanDBController.h"
#import <QuickLook/QuickLook.h>

@interface SBMenuController () <QLPreviewControllerDelegate,QLPreviewControllerDataSource>

/**数据源*/
@property(nonatomic,strong) NSMutableArray *datas;

/**chakna*/
/**<#comment#>*/
@property(nonatomic,copy) NSString *path;

@end

@implementation SBMenuController
static NSString * const ID = @"file";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    //设置UI
    [self setupUI];
    
    
    self.datas = [NSMutableArray arrayWithArray:[[SBWatcherManager shareManager] filesAtPath:self.homePath]];
    
}


#pragma mark - 设置UI
- (void)setupUI
{
    self.title = @"沙盒文件";
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:ID];
}


#pragma mark - UITableViewDatasource/UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //取出模型
    SBFileItem *item = self.datas[indexPath.row];
    
    cell.textLabel.text = item.name;
    
    if (item.isDirectory) {
        cell.imageView.image = [UIImage imageNamed:@"resource.bundle/directory"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"resource.bundle/file"];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出模型
    SBFileItem *item = self.datas[indexPath.row];
    
    //如果是目录
    if (item.isDirectory) {
        
        SBMenuController *menuVc = [[SBMenuController alloc] init];
        menuVc.homePath = item.fullPath;
        [self.navigationController pushViewController:menuVc animated:YES];
        
        
    }else{
        
        
        
        //如果是数据库文件，用专门的控制器查看
        if (item.fileType == SBFileTypeDB) {
            SBScanDBController *dbVc = [[SBScanDBController alloc] init];
            dbVc.dbFullPath = item.fullPath;
            dbVc.title = item.name;
            [self.navigationController pushViewController:dbVc animated:YES];
            return;
        }
        
        
        self.path = item.fullPath;
        QLPreviewController *myQlPreViewController = [[QLPreviewController alloc]init];
        myQlPreViewController.delegate =self;
        myQlPreViewController.dataSource =self;
        [myQlPreViewController setCurrentPreviewItemIndex:0];
        [self presentViewController:myQlPreViewController animated:YES completion:nil];
        
    }
    
}


- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller
{
    return 1;
}
 
- (id)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    
    
    
    return [NSURL fileURLWithPath:self.path];
    
}





#pragma mark - lazy
- (NSMutableArray *)datas
{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}


@end
