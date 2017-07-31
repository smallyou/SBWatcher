//
//  SBScanDataController.h
//  SBWatcher
//
//  Created by 23 on 2017/7/30.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBScanDataController : UIViewController

/**sql语句*/
@property(nonatomic,copy) NSString *sql;

/**当前的数据*/
@property(nonatomic,strong) NSArray *datas;

@end
