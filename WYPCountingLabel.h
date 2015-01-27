//
//  WYPCountingLabel.h
//  WYPCountingLabel
//
//  Created by 王易平 on 15/1/27.
//  Copyright (c) 2015年 王易平. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WYPCountingHandler)(BOOL finished);

@interface WYPCountingLabel : UILabel

@property (nonatomic, readonly) CFTimeInterval duration;
@property (nonatomic, readonly) NSInteger from;
@property (nonatomic, assign) NSInteger to;

-(void) startCountingFrom:(NSInteger) from to:(NSInteger)to duration:(CFTimeInterval)duration completion:(WYPCountingHandler)completion;

-(void) pause;
-(void) resume;

@end
