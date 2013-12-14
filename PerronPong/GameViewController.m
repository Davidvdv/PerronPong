//
//  ViewController.m
//  PerronPong
//
//  Created by David van de Vondervoort on 02-12-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import <AVFoundation/AVFoundation.h>

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.opaque = NO;
    skView.backgroundColor = [UIColor clearColor];
    
    // Create and configure the scene.
    //GameScene *scene = [[GameScene alloc] initWithSize:skView.bounds.size andBackgroundImage:_backgroundImage];
    GameScene *scene = [[GameScene alloc] initWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    AVCaptureSession *session = [[AVCaptureSession alloc] init];
	session.sessionPreset = AVCaptureSessionPresetMedium;
	
	AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
	captureVideoPreviewLayer.frame = self.view.bounds;
    
    [self.view.layer addSublayer:captureVideoPreviewLayer];
    
    /*
    UIView *videoview = [[UIView alloc] initWithFrame:self.view.bounds];
    [videoview.layer addSublayer:captureVideoPreviewLayer];
    
	//[self.view.layer addSublayer:captureVideoPreviewLayer];
    //[self.view.layer insertSublayer:captureVideoPreviewLayer below:self.view.layer];
     AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
     UIView *newView = [[UIView alloc] initWithFrame:SUBVIEW.bounds];
     [newView.layer addSublayer: captureVideoPreviewLayer];
     [SUBVIEW addSubview: newView];
     */
    
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

- (BOOL)shouldAutorotate
{
    return YES;
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

@end
