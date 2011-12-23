//
//  MoveBuff.m
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "MoveBuff.h"

@implementation MoveBuff

-(id)init:(NSString *)Move
{

    if (Move) {
        
    self = [super init];
    
    move = [NSString stringWithFormat:Move];
    
    return self;
    }
    
    else
    {
        return nil;
    
    }
}

@end
