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

-(void)applyBuff:(Turn *)turn
{

    bool penalty= NO;
    bool bonus= NO;
    
    if (element == @"Fire") {
        
        if (turn.weather.HotCold==1 && turn.weather.WetDry==0) {
            penalty = YES;
        }
        else
            if (turn.weather.HotCold ==0 && turn.weather.WetDry ==1) {
                bonus =YES;
            }
    }
    
    
    else
        if (element == @"Water") {
            
            if (turn.weather.HotCold==0 && turn.weather.WetDry==1) {
                penalty = YES;
            }
            else
                if (turn.weather.HotCold ==1 && turn.weather.WetDry ==0) {
                    bonus =YES;
                }
        }
    
                
    else
        if (element ==@"Air") {
            
            if (turn.weather.HotCold==0 && turn.weather.WetDry==1) {
                penalty = YES;
            }
            else
                if (turn.weather.HotCold ==1 && turn.weather.WetDry ==0) {
                    bonus =YES;
                }
        }
    
    
        
    else
    
        if (element ==@"Earth") {
            
            if (turn.weather.HotCold==0 && turn.weather.WetDry==0) {
                penalty = YES;
            }
            else
                if (turn.weather.HotCold ==1 && turn.weather.WetDry ==1) {
                    bonus =YES;
                }
        }
    
    
    
    //apply the buff accordingly
    
    if (penalty) {
        if (target) {
            turn.hisPlayer.power.ampMode = 2;
        }
        else
        {
            turn.myPlayer.power.ampMode =2;
        
        }
        
        
    }
    else
        if (bonus) {
            
            if (target) {
                turn.hisPlayer.power.ampMode =1;
            }
            else
            {
                turn.myPlayer.power.ampMode =1;
            }
            
        }
    
}
@end
