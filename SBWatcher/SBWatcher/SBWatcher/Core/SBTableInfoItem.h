//
//  SBTableInfoItem.h
//  SBWatcher
//
//  Created by 23 on 2017/7/30.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBTableInfoItem : NSObject

/**字段id*/
@property(nonatomic,copy) NSString *cid;

/**字段名称*/
@property(nonatomic,copy) NSString *name;

/**字段类型*/
@property(nonatomic,copy) NSString *type;

/**不能为空*/
@property(nonatomic,assign) BOOL notnull;

/**默认值*/
@property(nonatomic,copy) NSString *dflt_value;

/**是否主键*/
@property(nonatomic,assign) BOOL pk;

@end
