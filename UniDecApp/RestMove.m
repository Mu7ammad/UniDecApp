//
//  RestMove.m
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "RestMove.h"
#import "AttackMove.h"
#import "DefenseMove.h"

@implementation RestMove


-(Move *)winAgainst:(Move *)otherMove{//returns nill if both are the same class
    
    Move* winner;
    
    if ([otherMove isKindOfClass:[AttackMove class]]) {
        
        winner = otherMove;
    } else
        if ([otherMove isKindOfClass:[DefenseMove class]]) {
            
            winner = self;
        }
    
    return winner;
    
}

@end
