//
//  GCTurnBasedMatchHelper.h
//  pyramidia
//
//  Created by Muhammad Hilal on 1/2/12.
//  Copyright (c) 2012 Pirates. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GCTurnBasedMatchHelper : NSObject <GKTurnBasedMatchmakerViewControllerDelegate>
{
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    UIViewController *presentingViewController;
}

@property (assign, readonly) BOOL gameCenterAvailable;
@property (retain) GKTurnBasedMatch *currentMatch;

+ (GCTurnBasedMatchHelper*) sharedInstance;
-(void) authenticateLocalUser;
-(void) findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int) maxPlayers viewController:(UIViewController *)viewController;

@end
