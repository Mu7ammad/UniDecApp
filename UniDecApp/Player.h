//
//  Player.h
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Power.h"
#import "MoveProb.h"
#import "Move.h"

// connect to UI (stats)

@interface Player : NSObject
{
    Power* power;
    MoveProb* prob;

}

-(Move*) makeMove;

@end
