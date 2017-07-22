//
//  SBStartView.m
//  SBWatcher
//
//  Created by 23 on 2017/7/22.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import "SBStartView.h"
#import "SBMenuController.h"
#import "SBNavigationController.h"

@interface SBStartView ()

/**UIImageView*/
@property(nonatomic,weak) UIImageView *imageView;

@end

@implementation SBStartView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //setup UI
        [self setupUI];
    }
    return self;
}


#pragma mark - setup UI
/**setup UI*/
- (void)setupUI
{
    //设置图片
    UIImage *image = [UIImage imageNamed:@"resource.bundle/broswer"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imageView];
    self.imageView = imageView;
    
    //手势
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragView:)]];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)]];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

#pragma mark - 事件监听
/**拖动startView的手势*/
- (void)dragView:(UIPanGestureRecognizer *)recognizer
{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    
    CGPoint translation = [recognizer translationInView:view];
    CGPoint newCenter = CGPointMake(recognizer.view.center.x+ translation.x,
                                    recognizer.view.center.y + translation.y);//    限制屏幕范围：
    newCenter.y = MAX(recognizer.view.frame.size.height/2, newCenter.y);
    newCenter.y = MIN(view.frame.size.height - recognizer.view.frame.size.height/2,  newCenter.y);
    newCenter.x = MAX(recognizer.view.frame.size.width/2, newCenter.x);
    newCenter.x = MIN(view.frame.size.width - recognizer.view.frame.size.width/2,newCenter.x);
    recognizer.view.center = newCenter;
    [recognizer setTranslation:CGPointZero inView:view];
    
    //手势结束
    if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        
        CGPoint translation = [recognizer translationInView:view];
        CGPoint newCenter = CGPointMake(recognizer.view.center.x+ translation.x,
                                        recognizer.view.center.y + translation.y);//    限制屏幕范围：
        if (newCenter.x <= view.bounds.size.width * 0.5) {
            newCenter.x = recognizer.view.frame.size.width * 0.5;
        }else{
            newCenter.x = view.bounds.size.width - 0.5 * recognizer.view.frame.size.width;
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            recognizer.view.center = newCenter;
            [recognizer setTranslation:CGPointZero inView:view];
        }];
        
    }
}

/**点击startView的手势*/
- (void)tapView:(UITapGestureRecognizer *)recognizer
{
    SBMenuController *menuVc = [[SBMenuController alloc] init];
    menuVc.homePath = NSHomeDirectory();
    SBNavigationController *nav = [[SBNavigationController alloc] initWithRootViewController:menuVc];
    nav.startView = (SBStartView *)recognizer.view;
    nav.modalPresentationStyle = UIModalPresentationCustom;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:^{
        recognizer.view.hidden = YES;
    }];
}



@end
