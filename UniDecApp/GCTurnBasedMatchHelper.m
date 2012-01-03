//
//  GCTurnBasedMatchHelper.m
//  pyramidia
//
//  Created by Muhammad Hilal on 1/2/12.
//  Copyright (c) 2012 Pirates. All rights reserved.
//

#import "GCTurnBasedMatchHelper.h"

@implementation GCTurnBasedMatchHelper

@synthesize gameCenterAvailable, currentMatch;

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
    
    NSLog(@"Authenticating local user...");
    if ([GKLocalPlayer localPlayer].authenticated ==NO) {
        [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:nil];
    } else {
        NSLog(@"Already authenticated!");  
        
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
    NSLog(@"did find match, %@",match);
    
    self.currentMatch = match;
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

//quit
-(void)turnBasedMatchmakerViewController:(GKTurnBasedMatchmakerViewController *)viewController playerQuitForMatch:(GKTurnBasedMatch *)match{
    
    NSLog(@"player quit for match, %@, %@", match, match.currentParticipant);
}


@end
