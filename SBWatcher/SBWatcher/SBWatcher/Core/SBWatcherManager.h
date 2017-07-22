//
//  SBWatcherManager.h
//  SBWatcher
//
//  Created by 23 on 2017/7/22.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SBFileItem;

@interface SBWatcherManager : NSObject

#pragma mark - SangleLetgon
+ (instancetype)shareManager;


#pragma mark - API
/**registe watcher*/
- (void)registWatcher;

/**获取指定路径下的一级文件或目录*/
- (NSArray<SBFileItem *> *)filesAtPath:(NSString *)path;

@end
