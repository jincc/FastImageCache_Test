//
//  SCFPSLabel.m
//  IRanderTest
//
//  Created by junlongj on 16/1/13.
//  Copyright © 2016年 junlongj. All rights reserved.
//

#import "SCFPSLabel.h"
#import <QuartzCore/QuartzCore.h>
@interface SCFPSLabel()
{
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
}

@end


@implementation SCFPSLabel
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.clipsToBounds = YES;
    self.textAlignment = NSTextAlignmentCenter;
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor blackColor];
    self.font  = [UIFont systemFontOfSize:14];
    _link = [CADisplayLink displayLinkWithTarget:self
                                        selector:@selector(refresh:)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    return self;
}

- (void)dealloc {
    [_link invalidate];
}


- (void)refresh:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    if ((int)round(fps) > 40) {
        self.textColor = [UIColor greenColor];
    }else{
        self.textColor = [UIColor yellowColor];
    }
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    self.attributedText = text;
}

@end
