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
@synthesize myPlayer, opPlayer, weather, chargeMeter, myMove, hisMove, turnNo;


-(id)initWithTurnData:(NSDictionary*) data{
    
    self = [super init];
    
    NSNumber* num = [data objectForKey:@"turnNo"];
    turnNo = [num intValue];
    num = nil;
    
    
    //chargeMeter
    chargeMeter = [[ChargeMeter alloc]init];
    
    
    //init weather
    weather = [[Weather alloc]init];
    
    num = [data objectForKey:@"HotCold"];
    weather.HotCold = [num boolValue];
    num = nil;
    
    num = [data objectForKey:@"WetDry"];
    weather.WetDry = [num boolValue];
    num = nil;
    
    
    
    //**init myself
    
    //init myCharge
    if (turnNo>1) {//skip turn 0,1 
        
        num = [data objectForKey:@"myCharge"];
        int y = [num intValue];
        chargeMeter.myCharge = [num intValue];
        num = nil;

    } else {
        //full charge
        chargeMeter.myCharge =100;//***
        
    }
    
    
    //myPlayer -always from current profile-
    myPlayer = [[Player alloc]init];
    
    myPlayer.power.attackPower = [Profile sharedInstance].power.attackPower;
    myPlayer.power.defensePower = [Profile sharedInstance].power.defensePower;
    myPlayer.power.restPower = [Profile sharedInstance].power.restPower;
    

    
    //**init opponent
    
    if (turnNo==0) {//we still don't know about op
        
        chargeMeter.opUnavailable = YES;
        
    } else {
        
         //init opCharge
        chargeMeter.opUnavailable = NO;
        
        num = [data objectForKey:@"opCharge"];
        int z = [num intValue];
        chargeMeter.opCharge = [num intValue];
        num = nil;
        
        //init opPlayer
        opPlayer = [[Player alloc]init];
        
        num = [data objectForKey:@"opAttackPower"];
        int xx = [num intValue];
        opPlayer.power.attackPower = [num intValue];
        num = nil;
        
        num = [data objectForKey:@"opDefenesePower"];
        int yy = [num intValue];
        opPlayer.power.defensePower = [num intValue];
        num = nil;
        
        num = [data objectForKey:@"opRestPower"];
        int zz = [num intValue];
        opPlayer.power.restPower = [num intValue];
        num = nil;
    }

    
    return self;
}

-(void)evaluateTurn;
{
    
    //call after the turn is buffed
    
    [chargeMeter applyMoves:[myPlayer makeMove]:[opPlayer makeMove]];
    

}


@end
