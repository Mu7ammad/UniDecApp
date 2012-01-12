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
@synthesize myPlayer, hisPlayer, weather, chargeMeter, myMove, hisMove, turnNo;


-(id)initWithTurnData:(NSDictionary*) data{
    
    self = [super init];
    
    NSNumber* num;
    
    num = [data objectForKey:@"turnNo"];
    int x = [num intValue];
    turnNo = [num intValue];
    num = nil;
    
    
    //chargeMeter
    chargeMeter = [[ChargeMeter alloc]init];
    
    num = [data objectForKey:@"myCharge"];
    int y = [num intValue];
    chargeMeter.myCharge = [num intValue];
    num = nil;
    
    if ([data objectForKey:@"opCharge"]) {
    
        num = [data objectForKey:@"hisCharge"];
        int z = [num intValue];
        chargeMeter.myCharge = [num intValue];
        num = nil;
        
        chargeMeter.opUnavailable = NO;
        
    }else{
        
        chargeMeter.opUnavailable = YES;
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
        int xx = [num intValue];
        hisPlayer.power.attackPower = [num intValue];
        num = nil;
        
        num = [data objectForKey:@"opDefenesePower"];
        int yy = [num intValue];
        hisPlayer.power.defensePower = [num intValue];
        num = nil;
        
        num = [data objectForKey:@"opRestPower"];
        int zz = [num intValue];
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
