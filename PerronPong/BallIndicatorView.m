//
//  BallIndicatorView.m
//  PerronPong
//
//  Created by David van de Vondervoort on 15-01-14.
//  Copyright (c) 2014 David van de Vondervoort. All rights reserved.
//

#import "BallIndicatorView.h"

@implementation BallIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor purpleColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    rect.size.width = 200;
    rect.size.height = 200;
}
*/

-(void)indicatePosition:(CGFloat)position {
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        CGRect rect = self.frame;
        rect.origin.y = position;
        self.frame = rect;
    }completion:nil];
}

@end
