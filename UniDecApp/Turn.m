//
//  Turn.m
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "Turn.h"
#import "Profile.h"

@implementation Turn
@synthesize myPlayer, hisPlayer, weather, chargeMeter, myMove, hisMove, turnNo, initiator;


-(id)initWithTurnData:(NSDictionary*) data{
    
    self = [super init];
        
    //flags
    initiator = [data objectForKey:@"initiator"];
    
    NSNumber *num = [data objectForKey:@"turnNo"];
    turnNo = [num intValue];
    num = nil;
    
    
    //chargeMeter
    chargeMeter = [[ChargeMeter alloc]init];
    
    num = [data objectForKey:@"myCharge"];
    chargeMeter.myCharge = [num intValue];
    num = nil;
    
    if ([data objectForKey:@"hisCharge"]) {
    
        num = [data objectForKey:@"myCharge"];
        chargeMeter.myCharge = [num intValue];
        num = nil;
        
        chargeMeter.hisUnavailable = NO;
        
    }else{
        
        chargeMeter.hisUnavailable = YES;
    }
    
    
    //myPlayer
    myPlayer = [[Player alloc]init];
    
    myPlayer.power.attackPower = [Profile sharedInstance].power.attackPower;
    myPlayer.power.defensePower = [Profile sharedInstance].power.defensePower;
    myPlayer.power.restPower = [Profile sharedInstance].power.restPower;
    
    
    //hisPlayer (if present, if not first turn)
    if ([data objectForKey:@"opAttackPower"]) {
                
        hisPlayer = [[Player alloc]init];
        
        num = [data objectForKey:@"opAttackPower"];
        hisPlayer.power.attackPower = [num intValue];
        num = nil;
        
        num = [data objectForKey:@"opDefenesePower"];
        hisPlayer.power.defensePower = [num intValue];
        num = nil;
        
        num = [data objectForKey:@"opRestPower"];
        hisPlayer.power.restPower = [num intValue];
        num = nil;
    }
    
    
    
    
    
    return self;
}

-(void)evaluateTurn;
{
    
    //the turn is buffed, generate the moves

}


@end
