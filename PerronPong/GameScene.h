//
//  PongScene.h
//  PerronPong
//
//  Created by David van de Vondervoort on 13-12-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>

@interface GameScene : SKScene {
    double userMotion;
}

@property (strong, nonatomic) UIImage *backgroundImage;
@property (strong, nonatomic) CMMotionManager *gameMotionManager;

-(id)initWithSize:(CGSize)size andBackgroundImage:(UIImage *)backgroundImage;

@end
