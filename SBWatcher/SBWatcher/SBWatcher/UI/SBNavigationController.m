//
//  SBNavigationController.m
//  SBWatcher
//
//  Created by 23 on 2017/7/22.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import "SBNavigationController.h"
#define WeakSelf __weak typeof(self) weakSelf = self;

@interface SBNavigationController ()

@end

@implementation SBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"resource.bundle/fh"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"resource.bundle/cbsy"] style:UIBarButtonItemStyleDone target:self action:@selector(minWindow)];
    
    [super pushViewController:viewController animated:animated];
}


#pragma mark - 事件监听
/**返回*/
- (void)back
{
    [self popViewControllerAnimated:YES];
}

/**最小化*/
- (void)minWindow
{
    WeakSelf
    [self dismissViewControllerAnimated:YES completion:^{
        weakSelf.startView.hidden = NO;
    }];
}

@end
