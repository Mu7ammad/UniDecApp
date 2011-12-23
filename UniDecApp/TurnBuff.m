//
//  TurnBuff.m
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "TurnBuff.h"


@implementation TurnBuff

-(id)init:(NSString *)Turn
{
    if (Turn) {
        
        self=[super init];
        
        turn = [NSString stringWithFormat:Turn];
        
        return self;
    }
    
    else
    {
        return nil;
    
    }


}

@end
