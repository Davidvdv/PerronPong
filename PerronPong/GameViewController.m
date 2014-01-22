//
//  ViewController.m
//  PerronPong
//
//  Created by David van de Vondervoort on 02-12-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

#pragma mark - ViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Start the camera preview
    [self startCameraPreview];
    
    // Init and add a longpress gesture recognizer to start the game
    _longPressForShootingBall = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressForShootingBallHandler)];
    [self.gameView addGestureRecognizer:_longPressForShootingBall];
    
    // Init the game motion manager
    _gameMotionManager = [[CMMotionManager alloc] init];
    [_gameMotionManager setDeviceMotionUpdateInterval:1.0f/60.0f];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // When leaving this view controller stop the motion updates
    [_gameMotionManager stopDeviceMotionUpdates];
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - BallViewDelegate methods

-(void)ballIsOutOfBounds {
    
    // Stop de motion manager
    [_gameMotionManager stopAccelerometerUpdates];
    
    // Remove the ball from screen
    [_ball removeFromSuperview];
    
    // Add longpress gesture recognizer so the player can add a new ball
    [self.gameView addGestureRecognizer:_longPressForShootingBall];
    
    // Update the HUD
    [self updateBallCounter];
}

-(void)ballIsSmashed {
    // Get current score and increase by 1
    NSNumber *currentScore = [NSNumber numberWithInt:[_ballPongedCounterLabel.text intValue]];
    currentScore = [NSNumber numberWithInt:[currentScore intValue]+1];
    [_ballPongedCounterLabel setText:[currentScore stringValue]];
}

#pragma mark - Game methods

-(void)longPressForShootingBallHandler {
    
    // Get the location of the longpress
    CGPoint location = [_longPressForShootingBall locationInView:self.gameView];
    
    // Create a ball on the location
    [self createBallOnLocation:location];
    
    // Remove the longpress gesture recognizer to prevent adding a new ball
    [self.gameView removeGestureRecognizer:_longPressForShootingBall];
    
    [_instructionLabel setHidden:YES];
}

-(void)createBallOnLocation:(CGPoint)location {
    _ball = [[BallView alloc] initWithFrame:CGRectMake(location.x, location.y, 300, 300) andColor:[UIColor redColor]];
    _ball.delegate = self;
    [self.gameView addSubview:_ball];
    
    // Let the ball ponging
    [_ball ponging];
    
    // Control the current ball by the motion manager
    [self.gameMotionManager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            double yaw = deviceMotion.rotationRate.x*15;
            double roll = deviceMotion.rotationRate.y *10;
            [_ball moveXBy:roll andYBy:yaw];
        });
    }];
}

-(void)updateBallCounter {
    NSNumber *currentScore = [NSNumber numberWithInt:[_ballsLeftCounterLabel.text intValue]];
    currentScore = [NSNumber numberWithInt:[currentScore intValue]-1];
    if(currentScore == [NSNumber numberWithInt:0]) {
        [self gameIsOver];
    } else {
        [_ballsLeftCounterLabel setText:[currentScore stringValue]];
    }
}

-(void) gameIsOver {
    int64_t finalScore = [_ballPongedCounterLabel.text intValue];
    [[GCManager sharedInstance] insertScoreIntoLeaderboard:finalScore];
    [[GCManager sharedInstance] checkForAchievements:finalScore];
    
    UIAlertView *gameOverAlertView = [[UIAlertView alloc] initWithTitle:@"Game over" message:@"Je hebt geen ballen meer over!" delegate:self cancelButtonTitle:@"Hè, jammer!" otherButtonTitles:nil];
    [gameOverAlertView setDelegate:self];
    [gameOverAlertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.cancelButtonIndex == buttonIndex) {
        [self performSegueWithIdentifier:@"stopGameSegue" sender:self];
    }
}

-(void)startCameraPreview {
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    session.sessionPreset = AVCaptureSessionPresetMedium;
    
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    captureVideoPreviewLayer.frame = self.view.bounds;
    
    [self.previewCameraView.layer addSublayer:captureVideoPreviewLayer];
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (!input) {
        // Handle the error appropriately.
        NSLog(@"ERROR: trying to open camera: %@", error);
    }
    
    [session addInput:input];
    [session startRunning];
}

@end
