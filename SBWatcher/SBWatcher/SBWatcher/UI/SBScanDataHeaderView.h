//
//  SBScanDataHeaderView.h
//  SBWatcher
//
//  Created by 23 on 2017/7/31.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SBScanDataHeaderViewType) {
    SBScanDataHeaderViewTypeTitle  = 0,
    SBScanDataHeaderViewTypeRowsOne   = 1,
    SBScanDataHeaderViewTypeRowsTwo   = 2
    
};

@interface SBScanDataHeaderView : UITableViewHeaderFooterView

/**字符串数组*/
@property(nonatomic,copy) NSArray *titles;

/**类型*/
@property(nonatomic,assign) SBScanDataHeaderViewType type;

@end
