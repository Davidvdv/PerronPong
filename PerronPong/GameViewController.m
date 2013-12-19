//
//  ViewController.m
//  PerronPong
//
//  Created by David van de Vondervoort on 02-12-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController () {
    int ballCounter;
}

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ballCounter = 0;
    
    [self startCameraPreview];
    [self.scoreBoardLabel setText:@"0"];
    
    _shootBallSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(shootBall)];
    [_shootBallSwipe setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:_shootBallSwipe];
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];

    self.gameMotionManager = [[CMMotionManager alloc] init];
}

-(void) update:(CADisplayLink*)displayLink {
    if(_ball.isInFront && !CGRectIntersectsRect(_ball.frame, self.gameView.frame)) {
        [displayLink invalidate];
        NSLog(@"%d", (int)CGRectIntersectsRect(_ball.frame, self.gameView.frame));
        NSInteger currentScore = [_scoreBoardLabel.text integerValue];
        currentScore++;
        [_scoreBoardLabel setText:[NSString stringWithFormat:@"%ld", (long)currentScore]];
    }
}

-(void)shootBall {
    NSLog(@"shootBall");
    [self createBall];
    [self.view removeGestureRecognizer:_shootBallSwipe];
}

-(void)createBall {
    _ball = [[BallView alloc] initWithFrame:CGRectMake(150, 200, 300, 300) andColor:[UIColor redColor]];
    [self.gameView addSubview:_ball];
    [_ball ponging];
    ballCounter++;

    [self.gameMotionManager startDeviceMotionUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {
        if(error) { NSLog(@"%@", error); }
        dispatch_async(dispatch_get_main_queue(), ^{
            double pitch = deviceMotion.rotationRate.x*5;
            double roll = deviceMotion.attitude.roll *25;
            [_ball moveXBy:roll andYBy:pitch];
        });
    }];
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

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.gameMotionManager stopDeviceMotionUpdates];
}

@end
