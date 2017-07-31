//
//  SBScanDataCell.h
//  SBWatcher
//
//  Created by 23 on 2017/7/31.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBScanDataHeaderView;

@interface SBScanDataCell : UITableViewCell

/**字典数据*/
@property(nonatomic,strong) NSDictionary *dictionary;

@property(nonatomic,weak,readonly) SBScanDataHeaderView *titleView;
@end
