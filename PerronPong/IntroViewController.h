//
//  IntroViewController.h
//  PerronPong
//
//  Created by David van de Vondervoort on 19-12-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BallView.h"
#import "GameViewController.h"
#import <GameKit/GameKit.h>
#import "GCManager.h"

@interface IntroViewController : UIViewController <GKGameCenterControllerDelegate>

@property (strong, nonatomic) BallView *introBall;
- (IBAction)showGameCenterLeaderboard:(UIButton *)sender;

@end
