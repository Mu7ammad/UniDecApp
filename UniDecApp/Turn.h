//
//  Turn.h
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Move.h"

#import "Player.h"
#import "Weather.h"
#import "ChargeMeter.h"

@interface Turn : NSObject
{
    
    Player* me;
    Player* him;
    
    Weather* weather;
    
    ChargeMeter* chargeMeter;
    
}



-(void) executeTurn;

-(void) executePhase1;

-(void) executePhase2;

-(void) executePhase3;

-(void) executePhase4;

@end
