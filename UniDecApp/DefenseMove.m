//
//  DefendMove.m
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "DefenseMove.h"
#import "AttackMove.h"
#import "RestMove.h"

@implementation DefenseMove


-(Move *)winAgainst:(Move *)otherMove{//returns nill if both are the same class
    
    Move* winner;
    
    if ([otherMove isKindOfClass:[RestMove class]]) {
        
        winner = otherMove;
    } else
        if ([otherMove isKindOfClass:[AttackMove class]]) {
            
            winner = self;
        }
    
    return winner;
    
}

@end
