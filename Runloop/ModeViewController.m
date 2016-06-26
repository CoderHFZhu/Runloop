//
//  ModeViewController.m
//  Runloop
//
//  Created by zack on 16/6/26.
//  Copyright © 2016年 HF. All rights reserved.
//

#import "ModeViewController.h"

@interface ModeViewController ()
/** 线程对象 */
@property (nonatomic, strong) NSThread *thread;
@property (nonatomic, strong) NSPort *port;
@end

@implementation ModeViewController
-(NSPort *)port {
    if (!_port) {
        _port = [[NSPort alloc]init];
    }
    return _port;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(execute) object:nil];
    self.thread = thread;
        [thread start];
}

- (void)execute
{
    /** 当你为此时创建的runloop添加observer时，它并不能运行起来（线程还是会死掉的）
     //        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
     //    [NSRunLoop currentRunLoop] addTimer:<#(nonnull NSTimer *)#> forMode:<#(nonnull NSString *)#>
     只有你添加了以上两中方式才能确保runloop存在，线程不死*/
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"runloop进入");
                break;
                
            case kCFRunLoopBeforeTimers:
                NSLog(@"runloop要去处理timer");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"runloop要去处理Sources");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"runloop要睡觉了");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"runloop醒来啦");
                break;
                
            case kCFRunLoopExit:
                NSLog(@"runloop退出");
                break;
            default:
            break;
        }
    });
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    CFRelease(observer);
//
    /** 你可以尝试把下面的两种方式打开 查看一下打印效果*/
    /** 如果下面两行的任意一行都不添加只添加observer 是没有效果的*/
            [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    

//    [[NSRunLoop currentRunLoop] addTimer:[NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(show) userInfo:nil repeats:YES] forMode:NSDefaultRunLoopMode];

    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"------1111");
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}
- (void)test
{
    NSLog(@"----------test----%@", [NSThread currentThread]);
}
-(void)show{
    NSLog(@"----%@",[NSRunLoop currentRunLoop].currentMode);
}
@end
