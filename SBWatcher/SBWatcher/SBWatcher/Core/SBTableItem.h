//
//  SBTableItem.h
//  SBWatcher
//
//  Created by 23 on 2017/7/24.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SBTableItemType) {
    SBTableItemTypeTable    =   1,      //数据表
    SBTableItemTypeIndex    =   2       //索引
};

@interface SBTableItem : NSObject

/**type-类型*/
@property(nonatomic,copy) NSString *type;
/**类型*/
@property(nonatomic,assign) SBTableItemType itemType;
/**可显示类型*/
@property(nonatomic,copy) NSString *displayType;


/**name-类型名称*/
@property(nonatomic,copy) NSString *name;

/**tbl_name数据表名称*/
@property(nonatomic,copy) NSString *tbl_name;



@end
