//
//  ViewController.m
//  SBWatcher
//
//  Created by 23 on 2017/7/22.
//  Copyright © 2017年 smallyou. All rights reserved.
//

#import "ViewController.h"
#import "SBWatcherHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[SBWatcherManager shareManager] registWatcher];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSString *content = @"lasjlfjaslkfjlkasjflkasjflksajfljsalfjaslfjlskjfklsdj";
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    BOOL result = [[NSFileManager defaultManager] createFileAtPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"haha.html"] contents:data attributes:nil];
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.title = @"other";
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
    
}


@end
