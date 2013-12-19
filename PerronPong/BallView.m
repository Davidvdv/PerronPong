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

-(id)initWithFrame:(CGRect)frame andColor:(UIColor *)ballColor {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        _ballColor = ballColor;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, rect);
    CGContextSetFillColor(context, CGColorGetComponents([_ballColor CGColor]));
    CGContextFillPath(context);
}

-(void) moveXBy:(CGFloat)speedX andYBy:(CGFloat)speedY {
    CGRect rect = self.frame;
    rect.origin.x += speedX;
    rect.origin.y += speedY;
    self.frame = rect;
}

-(void) moveXTo:(CGFloat)xCordinate andYTo:(CGFloat)yCordinate {
    CGRect rect = self.frame;
    rect.origin.x = xCordinate;
    rect.origin.y = yCordinate;
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
            size = 300;
            _isInFront = YES;
        } else {
            size = 10;
            _isInFront = NO;
        }
        frame.size.width = size;
        frame.size.height = size;
        self.frame = frame;
    }completion:^(BOOL complete){
        [self ponging];
    }];
}

@end
