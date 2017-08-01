//
//  SBScanDataCell.m
//  SBWatcher
//
//  Created by 23 on 2017/7/31.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import "SBScanDataCell.h"
#import "SBScanDataHeaderView.h"

@interface SBScanDataCell ()

/**SBScanDataHeader*/
@property(nonatomic,weak) SBScanDataHeaderView *titleView;


@end

@implementation SBScanDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        SBScanDataHeaderView *titleView = [[SBScanDataHeaderView alloc] init];
        [self.contentView addSubview:titleView];
        self.titleView = titleView;
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleView.frame = self.contentView.bounds;
}

- (void)setDictionary:(NSDictionary *)dictionary
{
    _dictionary = dictionary;
    
    NSArray *titles = [dictionary allValues];
    self.titleView.titles = titles;
    
}


@end
