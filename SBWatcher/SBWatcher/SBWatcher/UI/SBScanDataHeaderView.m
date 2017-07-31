//
//  SBScanDataHeaderView.m
//  SBWatcher
//
//  Created by 23 on 2017/7/31.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import "SBScanDataHeaderView.h"

@interface SBScanDataHeaderView ()



@end

@implementation SBScanDataHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    }
    return self;
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    
    //移除
    for (UIView *sub in self.contentView.subviews) {
        [sub removeFromSuperview];
    }
    
    //添加
    for (int i = 0; i < self.titles.count; i++) {
        NSString *title = self.titles[i];
        UILabel *label = [[UILabel alloc] init];
        UIColor *color = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        if (self.type == SBScanDataHeaderViewTypeRowsOne) {
            color = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        }
        if (self.type == SBScanDataHeaderViewTypeRowsTwo) {
            color = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
        }
        label.backgroundColor = color;
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = i;
        [self.contentView addSubview:label];
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *subView in self.contentView.subviews) {
        if ([subView isKindOfClass:UILabel.class]) {
            
            CGFloat width = (1.0 * self.bounds.size.width - (self.titles.count - 1) ) / self.titles.count;
            subView.frame = CGRectMake(subView.tag * (width + 1), 0, width, self.contentView.bounds.size.height);
        
        }
    }
}


@end