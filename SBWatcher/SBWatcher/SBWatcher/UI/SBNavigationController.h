//
//  SBNavigationController.h
//  SBWatcher
//
//  Created by 23 on 2017/7/22.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBStartView.h"

@interface SBNavigationController : UINavigationController

/**startView*/
@property(nonatomic,weak) SBStartView *startView;

@end
