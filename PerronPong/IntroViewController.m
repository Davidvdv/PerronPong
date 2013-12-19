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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _introBall = [[BallView alloc] initWithFrame:CGRectMake(201, 200, 50, 50) andColor:[UIColor redColor]];
    [self.view addSubview:_introBall];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionUp];
    [_introBall addGestureRecognizer:swipe];
}

-(void)swipeHandler {
    [UIView animateWithDuration:2 animations:^{
        [_introBall moveByX:_introBall.position.x andY:87];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
