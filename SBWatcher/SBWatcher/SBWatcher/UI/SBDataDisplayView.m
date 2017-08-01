//
//  SBDataDisplayView.m
//  SBWatcher
//
//  Created by 23 on 2017/8/1.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import "SBDataDisplayView.h"

@interface SBDataDisplayView ()

/**label*/
@property(nonatomic,weak) UILabel *label;

@end

@implementation SBDataDisplayView

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [super init]) {
        
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        [self addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.label.frame = self.bounds;
    
}


@end
