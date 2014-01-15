//
//  GCManager.h
//  PerronPong
//
//  Created by David van de Vondervoort on 13-01-14.
//  Copyright (c) 2014 David van de Vondervoort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GCManager : NSObject

+ (GCManager *) sharedInstance;
+ (BOOL) isGameCenterAvailable;
- (void) authenticateLocalPlayer;
- (BOOL) islocalPlayerIsAuthenticated;
- (void) insertScoreIntoLeaderboard:(int64_t)score;
- (void) checkForAchievements:(int64_t)score;

@end
