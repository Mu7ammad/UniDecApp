//
//  Charge.m
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "ChargeMeter.h"


@implementation ChargeMeter
@synthesize myCharge,opCharge, myChargeLabel, opChargeLabel, opUnavailable;

-(void)applyMoves:(Move *)move1 :(Move *)move2{
    
    Move* winner = [move1 winAgainst:move2];

    if (winner) {
        //apply the winner effect
        
    }
    else {
        //apply the difference effect equally on both
        
    }
}
@end
