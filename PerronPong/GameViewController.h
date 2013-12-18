//
//  ViewController.h
//  PerronPong
//

//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMotion/CoreMotion.h>
#import "BallView.h"

@interface GameViewController : UIViewController

@property (strong, nonatomic) BallView *ball;
@property (strong, nonatomic) CMMotionManager *gameMotionManager;
@property (weak, nonatomic) IBOutlet UILabel *scoreBoardLabel;

-(void) createBall;

@end
