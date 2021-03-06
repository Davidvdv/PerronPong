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

// Move by a specific speed
-(void) moveXBy:(CGFloat)speedX andYBy:(CGFloat)speedY {
    CGRect rect = self.frame;
    rect.origin.x += speedX;
    rect.origin.y += speedY;
    self.frame = rect;
}

// Move to a coordinate
-(void) moveXTo:(CGFloat)xCordinate andYTo:(CGFloat)yCordinate {
    CGRect rect = self.frame;
    rect.origin.x = xCordinate;
    rect.origin.y = yCordinate;
    self.frame = rect;
}

-(void) scaleWidthTo:(CGFloat)widthSize andHeight:(CGFloat)heightSize {
    CGFloat sx = widthSize / self.frame.size.width;
    CGFloat sy = heightSize / self.frame.size.height;
    self.transform = CGAffineTransformMakeScale(sx, sy);
}

-(CGPoint)position {
    return self.frame.origin;
}

-(CGFloat)width {
    return self.frame.size.width;
}

-(CGFloat)height {
    return self.frame.size.height;
}

-(void)ponging {
    
    [UIView animateWithDuration:1 animations:^{
        // Ball is away
        if (self.width == 10) {
            //size = 300;
            [self scaleWidthTo:300 andHeight:300];
            _isInFront = NO;
        } else { // Ball is in front
            //size = 10;
            [self scaleWidthTo:10 andHeight:10];
            _isInFront = YES;
        }

    }completion:^(BOOL complete) {
        
        if(!(CGRectIntersectsRect(self.frame, self.superview.frame)) && self.isInFront) {
            // Ball passed by the player because the ball is out of bounds
            [self.delegate ballIsOutOfBounds];
        } else {
            if([self isInFront] && complete) {
                [self.delegate ballIsSmashed];
            }
            // Otherwise continue ponging
            [self ponging];
        }
    }];
}

@end
