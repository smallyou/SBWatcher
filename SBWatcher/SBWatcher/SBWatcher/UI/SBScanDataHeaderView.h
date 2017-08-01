//
//  SBScanDataHeaderView.h
//  SBWatcher
//
//  Created by 23 on 2017/7/31.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBScanDataHeaderView;

typedef NS_ENUM(NSInteger, SBScanDataHeaderViewType) {
    SBScanDataHeaderViewTypeTitle  = 0,
    SBScanDataHeaderViewTypeRowsOne   = 1,
    SBScanDataHeaderViewTypeRowsTwo   = 2
    
};

@protocol SBScanDataHeaderViewDelegate <NSObject>

- (void)headerView:(SBScanDataHeaderView *)headerView didLabelTaped:(UILabel *)label;

@end


@interface SBScanDataHeaderView : UIView

/**字符串数组*/
@property(nonatomic,copy) NSArray *titles;

/**类型*/
@property(nonatomic,assign) SBScanDataHeaderViewType type;

/**delegate*/
@property(nonatomic,weak) id<SBScanDataHeaderViewDelegate> delegate;

@end
