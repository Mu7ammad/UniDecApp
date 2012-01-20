//
//  AttackMove.m
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "AttackMove.h"
#import "DefenseMove.h"
#import "RestMove.h"

@implementation AttackMove

-(Move *)winAgainst:(Move *)otherMove{//returns nill if both are the same class
    
    Move* winner;
    
    if ([otherMove isKindOfClass:[DefenseMove class]]) {
        
        winner = otherMove;
    } else
        if ([otherMove isKindOfClass:[RestMove class]]) {
            
            winner = self;
        }
    
    return winner;
                              
}
@end
