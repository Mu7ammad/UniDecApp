//
//  Turn.h
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Buff.h"
#import "Move.h"

@interface Turn : NSObject
{
    NSArray* Buffs;
    
    Move *Move1, *Move2;
    

}

-(void) executeTurn;

-(void) executePhase1;

-(void) executePhase2;

-(void) executePhase3;

-(void) executePhase4;

@end
