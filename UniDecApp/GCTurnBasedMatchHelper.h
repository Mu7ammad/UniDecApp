//
//  GCTurnBasedMatchHelper.h
//  pyramidia
//
//  Created by Muhammad Hilal on 1/2/12.
//  Copyright (c) 2012 Pirates. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>


@protocol GCTurnBasedMatchHelperDelegate

-(void) enterNewGame: (GKTurnBasedMatch *)match;
-(void) layoutMatch: (GKTurnBasedMatch *) match;
-(void) takeTurn:(GKTurnBasedMatch *) match;
-(void)recieveEndGame: (GKTurnBasedMatch *)match;
-(void) sendNotice:(NSString *) notice forMatch:(GKTurnBasedMatch *)match;

@end

@interface GCTurnBasedMatchHelper : NSObject <GKTurnBasedMatchmakerViewControllerDelegate, GKTurnBasedEventHandlerDelegate>
{
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    UIViewController *presentingViewController;
    
    GKTurnBasedMatch *currentMatch;
    id <GCTurnBasedMatchHelperDelegate> delegate;
}
@property (nonatomic,retain) id<GCTurnBasedMatchHelperDelegate> delegate;

@property (assign, readonly) BOOL gameCenterAvailable;
@property (retain) GKTurnBasedMatch *currentMatch;

+ (GCTurnBasedMatchHelper*) sharedInstance;
-(void) authenticateLocalUser;
-(void) authenticationChanged;
-(void) findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int) maxPlayers viewController:(UIViewController *)viewController;

@end
