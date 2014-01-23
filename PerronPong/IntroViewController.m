//
//  IntroViewController.m
//  PerronPong
//
//  Created by David van de Vondervoort on 19-12-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // check if game center is available
    if([GCManager isGameCenterAvailable]) {
        // authenticate local player
        [[GCManager sharedInstance] authenticateLocalPlayer];
        
    }
    
	// Do any additional setup after loading the view.
    _introBall = [[BallView alloc] initWithFrame:CGRectMake(208, 300, 60, 60) andColor:[UIColor colorWithRed:200 green:200 blue:200 alpha:1]];
    [self.view addSubview:_introBall];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionUp];
    [_introBall addGestureRecognizer:swipe];
}

-(void)swipeHandler {
    [UIView animateWithDuration:1 animations:^{
        [_introBall scaleWidthTo:30 andHeight:30];
        [_introBall moveXTo:208 andYTo:29];
    } completion:^(BOOL finished){
        [self performSegueWithIdentifier:@"startGameSegue" sender:self];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showGameCenterLeaderboard:(UIButton *)sender {
    GKGameCenterViewController *gameCenterViewController = [[GKGameCenterViewController alloc] init];
    if (gameCenterViewController != nil) {
        gameCenterViewController.gameCenterDelegate = self;
        [self presentViewController:gameCenterViewController animated:YES completion:nil];
    }
}

-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
