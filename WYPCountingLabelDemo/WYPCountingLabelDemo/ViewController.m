//
//  ViewController.m
//  WYPCountingLabel
//
//  Created by 王易平 on 15/1/27.
//  Copyright (c) 2015年 王易平. All rights reserved.
//

#import "ViewController.h"
#import "WYPCountingLabel.h"

@interface ViewController ()
{
    WYPCountingLabel *countingLabel;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    countingLabel = [[WYPCountingLabel alloc] initWithFrame:self.view.bounds];
    countingLabel.textAlignment = NSTextAlignmentCenter;
    [countingLabel startCountingFrom:-100 to:100 duration:5 completion:^(BOOL finished) {
        NSLog(@"Finished: %@", finished?@"YES": @"NO");
    }];
    
    [self performSelector:@selector(refreshText) withObject:nil afterDelay:1.5f];
    
    [self performSelector:@selector(pause) withObject:nil afterDelay:1.0f];
    
    [self.view addSubview:countingLabel];
}

-(void) pause
{
    [countingLabel pause];
    
    [self performSelector:@selector(resume) withObject:nil afterDelay:1];
}

-(void) resume
{
    [countingLabel resume];
}

-(void) refreshText
{
    countingLabel.text = @"200";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
