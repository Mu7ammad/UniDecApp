//
//  Charge.h
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Move.h"

//connect to UI

@interface Charge : NSObject
{

    int c, boundary;
}

-(void) applyMoves:(Move*) move1 and:(Move*) move2;

@end
