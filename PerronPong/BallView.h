//
//  BallView.h
//  PerronPong
//
//  Created by David van de Vondervoort on 18-12-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BallViewDelegate <NSObject>

-(void)ballIsOutOfBounds;

@end

@interface BallView : UIView

@property (readonly, nonatomic) UIColor *ballColor;
@property (readonly, nonatomic) BOOL isInFront;
@property (weak, nonatomic) id <BallViewDelegate> delegate;

-(CGPoint) position;
-(void) moveXBy:(CGFloat)speedY andYBy:(CGFloat)speedX;
-(void) moveXTo:(CGFloat)xCordinate andYTo:(CGFloat)yCordinate;
-(void) ponging;

-(id)initWithFrame:(CGRect)frame andColor:(UIColor *)ballColor;

@end
