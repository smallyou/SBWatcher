//
//  SBFileItem.h
//  SBWatcher
//
//  Created by 23 on 2017/7/22.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,SBFileType) {
    SBFileTypeNone      =   0,      //无文件类型(包括目录、未识别类型)
    SBFileTypeBinary    =   1,      //二进制文件
    SBFileTypeText      =   2,      //文本文件
    SBFileTypeDB        =   3,      //数据库文件
    SBFileTypePlist     =   4       //plist文件
};


@interface SBFileItem : NSObject

/**文件或文件夹名称*/
@property(nonatomic,copy) NSString *name;

/**是否是目录*/
@property(nonatomic,assign) BOOL isDirectory;

/**文件或文件夹的全路径*/
@property(nonatomic,copy) NSString *fullPath;

/**文件类型*/
@property(nonatomic,assign) SBFileType fileType;

@end
