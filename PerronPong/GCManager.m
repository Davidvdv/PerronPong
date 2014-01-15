//
//  GCManager.m
//  PerronPong
//
//  Created by David van de Vondervoort on 13-01-14.
//  Copyright (c) 2014 David van de Vondervoort. All rights reserved.
//

#import "GCManager.h"

@implementation GCManager

static GCManager *sharedHelper = nil;
+ (GCManager *) sharedInstance {
    if (!sharedHelper) {
        sharedHelper = [[GCManager alloc] init];
    }
    return sharedHelper;
}

+ (BOOL) isGameCenterAvailable {
    // check for presence of GKLocalPlayer API
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    // check if the device is running iOS 4.1 or later
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    
    return (gcClass && osVersionSupported);
}

- (void) authenticateLocalPlayer {
    
    [GKLocalPlayer localPlayer].authenticateHandler = ^(UIViewController *viewController, NSError *error) {
        if (viewController != nil) {
            [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:viewController animated:YES completion:nil];
        }
    };
}

- (BOOL) islocalPlayerIsAuthenticated {
    return [GKLocalPlayer localPlayer].isAuthenticated;
}

- (void) insertScoreIntoLeaderboard:(int64_t)score {
    GKScore *scoreLeaderBoard = [[GKScore alloc] initWithLeaderboardIdentifier:@"PerronPongLeaderboard"];
    scoreLeaderBoard.value = score;
    [GKScore reportScores:@[scoreLeaderBoard] withCompletionHandler:^(NSError *error) {
        if (error) {
            NSLog(@"Inserting score to Game Center leaderboard failed.");
        }
    }];
}

- (void) checkForAchievements:(int64_t)score {
    NSString *achievementIdentifier;
    switch (score) {
        case 10:
            achievementIdentifier = @"PerronPongBeginner";
            break;
        
        case 25:
            achievementIdentifier = @"PerronPongPro";
            break;
            
        case 50:
            achievementIdentifier = @"PerronPongMaster";
            break;
            
        default:
            break;
    }
    
    if (achievementIdentifier != nil) {
        GKAchievement *achievement = [[GKAchievement alloc] initWithIdentifier:achievementIdentifier];
        [achievement setPercentComplete:100.0];
        [GKAchievement reportAchievements:@[achievement] withCompletionHandler:^(NSError *error) {
            if (error) {
                NSLog(@"Unlocking achievement failed.");
            }
        }];
    }
}

@end
