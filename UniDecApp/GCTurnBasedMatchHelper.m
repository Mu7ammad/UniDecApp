//
//  GCTurnBasedMatchHelper.m
//  pyramidia
//
//  Created by Muhammad Hilal on 1/2/12.
//  Copyright (c) 2012 Pirates. All rights reserved.
//

#import "GCTurnBasedMatchHelper.h"

@implementation GCTurnBasedMatchHelper

@synthesize gameCenterAvailable, currentMatch, delegate;

#pragma mark Initialization

static GCTurnBasedMatchHelper *sharedHelper = nil;

+(GCTurnBasedMatchHelper *)sharedInstance{
    
    if (!sharedHelper) {
        sharedHelper = [[GCTurnBasedMatchHelper alloc]init];
    }
    
    return sharedHelper;
}

-(BOOL)isGameCenterAvailable
{
    //taken straight from Apple's Game Kit Programming Guide
    
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice]systemVersion];
    
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    
    return (gcClass && osVersionSupported);
                     
}

-(id)init{
    
    
    if ((self = [super init])) {
        gameCenterAvailable = [self isGameCenterAvailable];
        if (gameCenterAvailable) {
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            [nc addObserver:self selector:@selector(authenticationChanged) name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
        }
    }
    
    return  self;
}

-(void) authenticationChanged{
    
    
    if ([GKLocalPlayer localPlayer].isAuthenticated && !userAuthenticated) {
        NSLog(@"Authentication changed: player authenticated.");
        userAuthenticated = YES;
    } else if (![GKLocalPlayer localPlayer].isAuthenticated && userAuthenticated){
        
        NSLog(@"Authentication changed: player not authenticated");
        userAuthenticated = NO;
    }
}

#pragma mark User functions

-(void)authenticateLocalUser{
    
    
    if (!gameCenterAvailable) return;
    
    void (^setGKEventHandlerDelegate)(NSError*) = ^(NSError *error){
        
        GKTurnBasedEventHandler *ev= [GKTurnBasedEventHandler sharedTurnBasedEventHandler];
        
        ev.delegate = self;
    };
    
    NSLog(@"Authenticating local user ...");
    
    
    
    if ([GKLocalPlayer localPlayer].authenticated ==NO) {
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:setGKEventHandlerDelegate];
        
        //to clear all previous matches uncommment this block instead
        /*
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError* error){
            
            [GKTurnBasedMatch loadMatchesWithCompletionHandler:^(NSArray* matches, NSError* error){
                
                for (GKTurnBasedMatch *match in matches) {
                    NSLog(@"%@",match.matchID);
                    
                    [match removeWithCompletionHandler:^(NSError* error){
                        NSLog(@"%@",error);
                    }];
                };
             }];
        }];
         */
        
        
    } else {
        NSLog(@"Already authenticated!");  
        setGKEventHandlerDelegate(nil);
        
    }
}

-(void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers viewController:(UIViewController *)viewController
{
    if (!gameCenterAvailable) {
        return;
    }
    
    presentingViewController = viewController;
    
    GKMatchRequest *request = [[GKMatchRequest alloc]init];
    request.minPlayers = minPlayers;
    request.maxPlayers = maxPlayers;
    
    GKTurnBasedMatchmakerViewController *mmvc = [[GKTurnBasedMatchmakerViewController alloc]initWithMatchRequest:request];
    mmvc.turnBasedMatchmakerDelegate = self;
    mmvc.showExistingMatches = YES;
    
    [presentingViewController presentModalViewController:mmvc animated:YES];
    
}

#pragma mark GKTurnBasedMatchmakerViewControllerDelegate

//match found
-(void) turnBasedMatchmakerViewController:(GKTurnBasedMatchmakerViewController *)viewController didFindMatch:(GKTurnBasedMatch *)match{
    
    [presentingViewController dismissModalViewControllerAnimated:YES];
    
    self.currentMatch = match;
    GKTurnBasedParticipant * firstParticipant = [match.participants objectAtIndex:0];
    if (firstParticipant.lastTurnDate==NULL) {
        //It's a new game !
        [delegate enterNewGame:match];
    
    }else {
        
        if ([match.currentParticipant.playerID isEqualToString:[GKLocalPlayer localPlayer].playerID]) {
            //It's my turn !
            
            [delegate takeTurn:match];
        } else {
            //It's not my turn
            [delegate layoutMatch:match];
        }
    }
    
}

//cancel
-(void)turnBasedMatchmakerViewControllerWasCancelled:(GKTurnBasedMatchmakerViewController *)viewController
{
    [presentingViewController dismissModalViewControllerAnimated:YES];
    
    NSLog(@"has cancelled");
    
}

//error
-(void)turnBasedMatchmakerViewController:(GKTurnBasedMatchmakerViewController *)viewController didFailWithError:(NSError *)error{
    
    [presentingViewController dismissModalViewControllerAnimated:YES];
    
    NSLog(@"Error finding match: %@", error.localizedDescription);
    
}

//quit -- hand the baton
-(void)turnBasedMatchmakerViewController:(GKTurnBasedMatchmakerViewController *)viewController playerQuitForMatch:(GKTurnBasedMatch *)match{
    
    NSUInteger currentIndex = [match.participants indexOfObject:match.currentParticipant];
    
    GKTurnBasedParticipant *part;
    
    //search for a player who hasn't quit
    for (int i=0; i<[match.participants count]; i++) {
        
        part = [match.participants objectAtIndex:(currentIndex+1+i)%match.participants.count];
        
        if (part.matchOutcome!= GKTurnBasedMatchOutcomeQuit) {
            break;
        }
    }
    
    NSLog(@"player quit for match, %@, %@", match, match.currentParticipant);
    
    [match participantQuitInTurnWithOutcome:GKTurnBasedMatchOutcomeQuit nextParticipant:part matchData:match.matchData completionHandler:nil];
    
}

#pragma mark GKTurnBasedEventHandlerDelegate

//you invited someone from Game Center App
-(void)handleInviteFromGameCenter:(NSArray *)playersToInvite{
    
    NSLog(@"new invite");
    
    [presentingViewController dismissModalViewControllerAnimated:YES];
    
    GKMatchRequest *request= [[GKMatchRequest alloc]init];
    
    request.maxPlayers =2;
    request.minPlayers =2;
    
    GKTurnBasedMatchmakerViewController *viewController = [[GKTurnBasedMatchmakerViewController alloc]initWithMatchRequest:request];
    
    viewController.showExistingMatches = NO;
    viewController.turnBasedMatchmakerDelegate= self;
    
    [presentingViewController presentModalViewController:viewController animated:YES];
    
    
}

-(void)handleTurnEventForMatch:(GKTurnBasedMatch *)match{
    
    NSLog(@"turn has happened");
    
    if ([match.matchID isEqualToString:currentMatch.matchID]) {
        if ([match.currentParticipant.playerID isEqualToString:[GKLocalPlayer localPlayer].playerID]) {
            //it's the current match and it's my turn now
            
            self.currentMatch=match;
            
            [delegate takeTurn:match];
                        
        } else {
            
            //it's the current match, but it's someone else's turn
            
            self.currentMatch = match;
            
            [delegate layoutMatch:match];
        }
        
    } else {
        
        if ([match.currentParticipant.playerID isEqualToString:[GKLocalPlayer localPlayer].playerID]) {
            //it's not the current match and it's my turn now
            
            [delegate sendNotice:@"It's my turn for another match" forMatch:match];
        } else {
            
            //it's not the current match, and it's someone else's turn
        }
    }
}

-(void)handleMatchEnded:(GKTurnBasedMatch *)match{
    
    NSLog(@"match has ended");
    
    if ([match.matchID isEqualToString:currentMatch.matchID]) {
        [delegate recieveEndGame:match];
    } else {
        
        [delegate sendNotice:@"Another Game Ended !" forMatch:match];
    }
}


@end
