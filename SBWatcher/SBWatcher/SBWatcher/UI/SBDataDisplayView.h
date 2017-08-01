//
//  SBDataDisplayView.h
//  SBWatcher
//
//  Created by 23 on 2017/8/1.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBDataDisplayView : UIView

- (instancetype)initWithTitle:(NSString *)title;

/**label*/
@property(nonatomic,weak,readonly) UILabel *label;
@end
