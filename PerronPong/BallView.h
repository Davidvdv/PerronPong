//
//  BallView.h
//  PerronPong
//
//  Created by David van de Vondervoort on 18-12-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BallView : UIView

@property (readonly, nonatomic) BOOL isInFront;

-(CGPoint) position;
-(void) moveByX:(CGFloat)speedY andY:(CGFloat)speedX;
-(void) ponging;

@end
