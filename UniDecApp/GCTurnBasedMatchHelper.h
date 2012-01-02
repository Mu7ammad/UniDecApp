//
//  GCTurnBasedMatchHelper.h
//  pyramidia
//
//  Created by Muhammad Hilal on 1/2/12.
//  Copyright (c) 2012 Pirates. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GCTurnBasedMatchHelper : NSObject
{
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;

}

@property (assign, readonly) BOOL gameCenterAvailable;

+ (GCTurnBasedMatchHelper*) sharedInstance;
-(void) authenticateLocalUser;


@end
