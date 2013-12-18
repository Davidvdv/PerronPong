//
//  BallView.m
//  PerronPong
//
//  Created by David van de Vondervoort on 18-12-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import "BallView.h"

@implementation BallView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColor(ctx, CGColorGetComponents([[UIColor blueColor] CGColor]));
    CGContextFillPath(ctx);
}

-(void) moveByX:(CGFloat)speedX andY:(CGFloat)speedY{
    CGRect rect = self.frame;
    rect.origin.x += speedX;
    rect.origin.y += speedY;
    self.frame = rect;
}

-(CGPoint)position {
    return self.frame.origin;
}

-(void)ponging {
    [UIView animateWithDuration:1 animations:^{
        CGRect frame = self.frame;
        CGFloat size;
        if (frame.size.width == 10) {
            size = 50;
        } else {
            size = 10;
        }
        frame.size.width = size;
        frame.size.height = size;
        self.frame = frame;
    }completion:^(BOOL complete){
        [self ponging];
    }];
}

@end
