//
//  Power.m
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "Power.h"

@implementation Power
@synthesize attackPower,defensePower,restPower, ampMode;

-(int)givePowerforMove:(int)move
{
    int power;
    switch (move) {
        case 0://attack
        
            power = attackPower;
            
        break;
        
        case 1://defense
            
            power = defensePower;
            
        break;
            
        case 2://rest
            
            power = restPower;
        break;
        
    }
    
    
    switch (ampMode) {
        case 1:// bonus power
                
            power = power*1.5;
            
        break;
        
        case 2://penalty power
            
            power = power *0.5;
            
        break;
            
        default:
            break;
    }
    
    
    return power;
}

@end
