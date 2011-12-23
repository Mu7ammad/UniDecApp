//
//  ElementBuff.m
//  UniDecApp
//
//  Created by Muhammad Hilal on 12/23/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "ElementBuff.h"

@implementation ElementBuff

-(id)init: (NSString*) Element
{
    if (Element) {
        
    self = [super init];
    
    element = [NSString stringWithFormat:Element];
    
    return self;
    }
    
    else
    {
        return nil;
    
    }
}

@end
