//
//  WYPCountingLabel.m
//  WYPCountingLabel
//
//  Created by 王易平 on 15/1/27.
//  Copyright (c) 2015年 王易平. All rights reserved.
//

#import "WYPCountingLabel.h"

static CFTimeInterval defaultDuration = 2;

@interface WYPCountingLabel ()
{
    CADisplayLink *displayLink;
    CFTimeInterval _time;
    NSInteger currentCount;
}

@property (nonatomic, strong) WYPCountingHandler completionHandler;

@end

@implementation WYPCountingLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setText:(NSString *)text
{
    NSInteger from = 0;
    if ([self.text integerValue]) {
        from = self.text.integerValue;
    }
    if ([text integerValue]) {
        [self startCountingFrom:from to:text.integerValue duration:defaultDuration completion:nil];
    }
    else {
        [super setText:text];
    }
}

-(void)startCountingFrom:(NSInteger)from to:(NSInteger)to duration:(CFTimeInterval)duration completion:(WYPCountingHandler)completion
{
    _from = from;
    _to = to;
    _duration = duration;
    
    self.completionHandler = completion;
    
    [displayLink invalidate];
    displayLink = nil;
    
    _time = 0;
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(count)];
    displayLink.frameInterval = 1;
    
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

-(void)pause
{
    displayLink.paused = YES;
    if (self.completionHandler) {
        self.completionHandler(NO);
    }
}

-(void)resume
{
    displayLink.paused = NO;
}

-(void) count
{
    _time += displayLink.duration;
    if (_time >= self.duration) {
        [displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [displayLink invalidate];
        displayLink = nil;
        
        [super setText:[NSString stringWithFormat:@"%ld", (long)self.to]];
        
        if (self.completionHandler) {
            self.completionHandler(YES);
        }
    }
    else {
        CGFloat rate = _time / self.duration;
        NSInteger count = self.from + (self.to - self.from) * rate;
        
        [super setText:[NSString stringWithFormat:@"%ld", (long)count]];
    }
}

@end
