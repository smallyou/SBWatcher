//
//  SBWatcherManager.m
//  SBWatcher
//
//  Created by 23 on 2017/7/22.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import "SBWatcherManager.h"

#import "SBStartView.h"

#import "SBFileItem.h"

@interface SBWatcherManager () <UIGestureRecognizerDelegate>

/**start view*/
@property(nonatomic,weak) SBStartView *startView;

@end


@implementation SBWatcherManager

#pragma mark - SangleLetgon
static id _instance;
+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark - API
/**注册*/
- (void)registWatcher
{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    self.startView.frame = CGRectMake(0, view.frame.size.height - 100 - 44, 44, 44);
}

/**获取指定路径下的一级文件或目录*/
- (NSArray<SBFileItem *> *)filesAtPath:(NSString *)path
{
    NSMutableArray *arrayM = [NSMutableArray array];
    NSError *error = nil;
    NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
    
    for (NSString *fileName in array) {
        
        //构造文件全路径
        NSString *fullPath = [path stringByAppendingPathComponent:fileName];
        
        BOOL isDirectory = NO;
        [[NSFileManager defaultManager] fileExistsAtPath:fullPath isDirectory:&isDirectory];
        
        //判断文件类型
        SBFileType type = SBFileTypeNone;
        if (!isDirectory) {
            type = [self typeOfFilePath:fullPath];
        }
        
        SBFileItem *item = [[SBFileItem alloc] init];
        item.name = fileName;
        item.isDirectory = isDirectory;
        item.fullPath = fullPath;
        item.fileType = type;
        
        if (isDirectory) {
            [arrayM insertObject:item atIndex:0];
        }else{
            [arrayM addObject:item];
        }
        
    }
    
    
    return arrayM;
}


/**根据文件全路径 判断文件的类型*/
- (SBFileType )typeOfFilePath:(NSString *)filePath
{
    SBFileType type = SBFileTypeNone;
    
    //获取文件的后缀
    if ([filePath hasSuffix:@"plist"]||[filePath hasSuffix:@"PLIST"]) {
        type = SBFileTypePlist;
    }else if ([filePath hasSuffix:@"txt"] || [filePath hasSuffix:@"TXT"]){
        type = SBFileTypeText;
    }else if ([filePath hasSuffix:@"DB"] || [filePath hasSuffix:@"db"] || [filePath hasSuffix:@"sqlite"] || [filePath hasSuffix:@"SQLITE"]){
        type = SBFileTypeDB;
    }
    
    return type;
}




#pragma mark - lazy
- (SBStartView *)startView
{
    if (_startView == nil) {
        
        SBStartView *startView = [[SBStartView alloc] init];
        [[UIApplication sharedApplication].keyWindow addSubview:startView];
        _startView = startView;
    }
    return _startView;
}



@end
