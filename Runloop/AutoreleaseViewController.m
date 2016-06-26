//
//  AutoreleaseViewController.m
//  Runloop
//
//  Created by zack on 16/6/26.
//  Copyright © 2016年 HF. All rights reserved.
//

#import "AutoreleaseViewController.h"

@interface AutoreleaseViewController ()

@end

@implementation AutoreleaseViewController



/*
 kCFRunLoopEntry = (1UL << 0),  1
 kCFRunLoopBeforeTimers = (1UL << 1), 2
 kCFRunLoopBeforeSources = (1UL << 2), 4
 kCFRunLoopBeforeWaiting = (1UL << 5), 32
 kCFRunLoopAfterWaiting = (1UL << 6), 64
 kCFRunLoopExit = (1UL << 7), 128
 */

// activities = 0x1 == 1
// activities = 0xa0 == 160


//<CFRunLoopObserver 0x7fe6a3611c50 [0x10a417a40]>{valid = Yes, activities = 0x1, repeats = Yes, order = -2147483647, callout = _wrapRunLoopWithAutoreleasePoolHandler (0x10a59e4c2), context = <CFArray 0x7fe6a3611ae0 [0x10a417a40]>{type = mutable-small, count = 1, values = (
//                                                                                                                                                                                                                                                                                0 : <0x7fe6a4800048>
//                                                                                                                                                                                                                                                                                )}}

//<CFRunLoopObserver 0x7fe6a3611d30 [0x10a417a40]>{valid = Yes, activities = 0xa0, repeats = Yes, order = 2147483647, callout = _wrapRunLoopWithAutoreleasePoolHandler (0x10a59e4c2), context = <CFArray 0x7fe6a3611ae0 [0x10a417a40]>{type = mutable-small, count = 1, values = (
//                                                                                                                                                                                                                                                                                0 : <0x7fe6a4800048>
//                                                                                                                                                                                                                                                                                )}}

/** 查看上面的activities   发现 监听的是下面三个值   0xa0 == 160
 kCFRunLoopBeforeWaitin|kCFRunLoopExit == 160
 */

/**
kCFRunLoopEntry = (1UL << 0),  1
+
kCFRunLoopBeforeWaiting = (1UL << 5), 32
kCFRunLoopExit = (1UL << 7), 128
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", [NSRunLoop currentRunLoop]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
