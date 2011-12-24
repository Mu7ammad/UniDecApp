//
//  Turn.m
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "Turn.h"

@implementation Turn
@synthesize me, him, weather, chargeMeter;


-(id)init
{
    self = [super init];
    
    me = [[Player alloc]init];
    him = [[Player alloc]init];
    
    weather = [[Weather alloc]init];
    
    chargeMeter = [[ChargeMeter alloc]init];
    
    return self;
}
@end
