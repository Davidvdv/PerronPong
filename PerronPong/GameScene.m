//
//  PongScene.m
//  PerronPong
//
//  Created by David van de Vondervoort on 13-12-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        // Creating the ball
        SKShapeNode *ball = [[SKShapeNode alloc] init];
        CGMutablePathRef ballRef = CGPathCreateMutable();
        CGPathAddArc(ballRef, nil, 0, 0, 50, 0, M_PI*2, YES);
        [ball setPath:ballRef];
        [ball setAntialiased:YES];
        [ball setLineWidth:0];
        [ball setFillColor:[SKColor greenColor]];
        [ball setPosition:CGPointMake(50, 50)];
        [ball setSpeed:5];
        [ball setName:@"theBall"];
        
        // Init ball actions
        SKAction *scaleSmall = [SKAction scaleTo:0.1 duration:2];
        SKAction *scaleBig= [SKAction scaleTo:1.0 duration:2];
        SKAction *moveUpAction = [SKAction moveToY:size.height-(ball.frame.size.height/2) duration:2];
        SKAction *moveDownAction = [SKAction moveToY:ball.frame.size.height/2 duration:2];
        SKAction *moveActions = [SKAction repeatActionForever:[SKAction sequence:@[moveUpAction, moveDownAction]]];
        SKAction *scaleActions = [SKAction repeatActionForever:[SKAction sequence:@[scaleSmall, scaleBig]]];
        [ball runAction:[SKAction group:@[scaleActions, moveActions]]];
        
        // Add Ball to the scene
        [self addChild:ball];
        
        self.gameMotionManager = [[CMMotionManager alloc] init];
        [self.gameMotionManager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {
            if(error) {
                NSLog(@"%@", error);
            }
            double roll = deviceMotion.attitude.roll; // x
            //double pitch = deviceMotion.attitude.pitch; // y
            [ball setPosition:CGPointMake(ball.position.x+roll*15, ball.position.y)];
        }];
    }
    return self;
}

-(id)initWithSize:(CGSize)size andBackgroundImage:(UIImage *)backgroundImage {
    if (self = [super initWithSize:size]) {
        // Setting background of the scene
        
        // debug
        if(backgroundImage != nil) {
            SKTexture *backgroundTexture = [SKTexture textureWithImage:backgroundImage];
            SKSpriteNode *backgroundSN = [SKSpriteNode spriteNodeWithTexture:backgroundTexture];
            backgroundSN.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
            backgroundSN.name = @"backgroundImage";
            backgroundSN.size = size;
            [self addChild:backgroundSN];
        }

        // Creating the ball
        Ball *ball = [[Ball alloc] init];
        CGMutablePathRef ballRef = CGPathCreateMutable();
        CGPathAddArc(ballRef, nil, 0, 0, 50, 0, M_PI*2, YES);
        [ball setPath:ballRef];
        [ball setAntialiased:YES];
        [ball setLineWidth:0];
        [ball setFillColor:[SKColor greenColor]];
        [ball setPosition:CGPointMake(50, 50)];
        //[ball setSpeed:10];
        [ball setName:@"theBall"];
        
        // Init ball actions
        SKAction *scaleSmall = [SKAction scaleTo:0.1 duration:2];
        SKAction *scaleBig= [SKAction scaleTo:1.0 duration:2];
        SKAction *moveUpAction = [SKAction moveToY:size.height-(ball.frame.size.height/2) duration:2];
        SKAction *moveDownAction = [SKAction moveToY:ball.frame.size.height/2 duration:2];
        SKAction *moveActions = [SKAction repeatActionForever:[SKAction sequence:@[moveUpAction, moveDownAction]]];
        SKAction *scaleActions = [SKAction repeatActionForever:[SKAction sequence:@[scaleSmall, scaleBig]]];
        [ball runAction:[SKAction group:@[scaleActions, moveActions]]];

        // Add Ball to the scene
        [self addChild:ball];
        
        self.gameMotionManager = [[CMMotionManager alloc] init];
        [self.gameMotionManager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {
            if(error) {
                NSLog(@"%@", error);
            }
            double roll = deviceMotion.attitude.roll; // x
            //double pitch = deviceMotion.attitude.pitch; // y
            [ball setPosition:CGPointMake(ball.position.x+roll*15, ball.position.y)];
        }];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view {
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector( handleSwipeAction)];
    [swipe setDirection: UISwipeGestureRecognizerDirectionUp];
    [view addGestureRecognizer:swipe];
}

- (void)handleSwipeAction {
    NSLog(@"handleSwipeAction");
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        NSLog(@"%@", NSStringFromCGPoint(location));
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
//    Ball *ball = (Ball *)[self childNodeWithName:@"theBall"];
//    if(ball.position.y > ([UIScreen mainScreen].bounds.size.height - (ball.frame.size.width/2)) && ball.speed > 0) {
//        ball.speed = -5;
//    } else if (ball.position.y < (ball.frame.size.height/2) && ball.speed < 0) {
//       ball.speed = 5;
//    }
//
//    CGFloat newX;
//    //ball.position.x < ([UIScreen mainScreen].bounds.size.width - (ball.frame.size.width/2)) ||
//    if(ball.position.x > (ball.frame.size.width)) {
//        newX = ball.position.x+userMotion*15;
//    } else {
//        newX = ball.position.x;
//    }
//    
//    [ball setPosition:CGPointMake(newX, ball.position.y+ball.speed)];
//    NSLog(@"%f", ball.position.x);
}

@end
