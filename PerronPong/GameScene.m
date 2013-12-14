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
        [ball setSpeed:10];
        [ball setName:@"theBall"];
        
        // Init ball actions
        SKAction *scaleAction = [SKAction scaleTo:0.2 duration:15];
        SKAction *repeatScale = [SKAction repeatActionForever:scaleAction];
        [ball runAction:repeatScale];
        
        // Add Ball to the scene
        [self addChild:ball];
        
        self.gameMotionManager = [[CMMotionManager alloc] init];
        [self.gameMotionManager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {
            if(error) {
                NSLog(@"%@", error);
            }
            userMotion = deviceMotion.attitude.roll;
        }];
    }
    return self;
}

-(id)initWithSize:(CGSize)size andBackgroundImage:(UIImage *)backgroundImage {
    if (self = [super initWithSize:size]) {
        // Setting background of the scene
        SKTexture *backgroundTexture = [SKTexture textureWithImage:backgroundImage];
        SKSpriteNode *backgroundSN = [SKSpriteNode spriteNodeWithTexture:backgroundTexture];
        backgroundSN.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        backgroundSN.name = @"backgroundImage";
        [backgroundSN setSize:size];
        [self addChild:backgroundSN];
        
        // Creating the ball
        SKShapeNode *ball = [[SKShapeNode alloc] init];
        CGMutablePathRef ballRef = CGPathCreateMutable();
        CGPathAddArc(ballRef, nil, 0, 0, 50, 0, M_PI*2, YES);
        [ball setPath:ballRef];
        [ball setAntialiased:YES];
        [ball setLineWidth:0];
        [ball setFillColor:[SKColor greenColor]];
        [ball setPosition:CGPointMake(50, 50)];
        [ball setSpeed:10];
        [ball setName:@"theBall"];
        
        // Init ball actions
        SKAction *scaleAction = [SKAction scaleTo:0.2 duration:15];
        SKAction *repeatScale = [SKAction repeatActionForever:scaleAction];
        [ball runAction:repeatScale];
        
        // Add Ball to the scene
        [self addChild:ball];
        
        self.gameMotionManager = [[CMMotionManager alloc] init];
        [self.gameMotionManager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {
            if(error) {
                NSLog(@"%@", error);
            }
            userMotion = deviceMotion.attitude.roll;
            NSLog(@"%f", userMotion);
        }];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view {
    NSLog(@"didMoveToView");
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector( handleSwipeAction)];
    [swipe setDirection: UISwipeGestureRecognizerDirectionUp];
    [view addGestureRecognizer:swipe];
}

- (void)handleSwipeAction {
    NSLog(@"handleSwipeAction");
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    SKNode *ball = [self childNodeWithName:@"theBall"];
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        NSLog(@"%@", NSStringFromCGPoint(location));
        [ball setSpeed:5];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    SKNode *ball = [self childNodeWithName:@"theBall"];
    if(ball.position.y > ([UIScreen mainScreen].bounds.size.height - (ball.frame.size.width/2)) && ball.speed > 0) {
        ball.speed = -5;
    } else if (ball.position.y < (ball.frame.size.height/2) && ball.speed < 0) {
       ball.speed = 5;
    }
    [ball setPosition:CGPointMake(ball.position.x+userMotion*15, ball.position.y+ball.speed)];
}

@end
