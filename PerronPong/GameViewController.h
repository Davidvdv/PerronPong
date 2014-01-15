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
#import "BallIndicatorView.h"
#import "IntroViewController.h"

@interface GameViewController : UIViewController <BallViewDelegate>

@property (strong, nonatomic) BallView *ball;
@property (strong, nonatomic) BallIndicatorView *ballIndicator;
@property (strong, nonatomic) CMMotionManager *gameMotionManager;

@property (weak, nonatomic) IBOutlet UIView *previewCameraView;
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UILabel *ballsLeftCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (weak, nonatomic) IBOutlet UILabel *ballPongedCounterLabel;
@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *longPressForShootingBall;

@property (strong, nonatomic) NSDate *lastUpdateTime;

-(void) createBallOnLocation:(CGPoint)location;
-(void) updateBallCounter;
-(void) gameIsOver;

@end
