//
//  Turn.m
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "Turn.h"

@implementation Turn
@synthesize myPlayer, hisPlayer, weather, chargeMeter, myMove, hisMove, turnNo;


-(id)init
{
    self = [super init];
    
    myPlayer = [[Player alloc]init];
    hisPlayer = [[Player alloc]init];
    
    weather = [[Weather alloc]init];
    
    chargeMeter = [[ChargeMeter alloc]init];
    
    return self;
}

-(void)evaluateTurn;
{
    
    //the turn is buffed, generate the moves

}
@end
