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
    
	// Do any additional setup after loading the view.
    _introBall = [[BallView alloc] initWithFrame:CGRectMake(208, 350, 30, 30) andColor:[UIColor colorWithRed:200 green:200 blue:200 alpha:1]];
    [self.view addSubview:_introBall];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionUp];
    [_introBall addGestureRecognizer:swipe];
}

-(void)swipeHandler {
    [UIView animateWithDuration:1 animations:^{
        [_introBall moveXTo:208 andYTo:29];
    } completion:^(BOOL finished){
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        GameViewController *gameViewController = [sb instantiateViewControllerWithIdentifier:@"GameViewController"];
        [self.navigationController pushViewController:gameViewController animated:YES];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
