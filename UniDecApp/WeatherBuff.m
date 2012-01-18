//
//  WeatherBuff.m
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "WeatherBuff.h"

@implementation WeatherBuff

-(id)init:(NSString *)Weather
{
    if (Weather) {
        self = [super init];
        
        weather = [NSString stringWithFormat:Weather];
        
        return self;
    }
    
    else
    {
        return nil;
    }


}

-(void)applyBuff:(Turn *)turn

{

    if (weather ==@"Winter") {//wet cold
        
        turn.weather.nextWetDry=0;
        
        turn.weather.nextHotCold=1;
    }
    else
        if (weather ==@"Summer"
            ) {//dry hot
            
            turn.weather.nextWetDry=1;
            
            turn.weather.nextHotCold=0;        
        }
    else
        if (weather ==@"Autumn") {//dry cold
                
            turn.weather.nextWetDry=1;
            
            turn.weather.nextHotCold=1;        
        }
    else
        if (weather ==@"Spring") {//wet hot
                    
            turn.weather.nextWetDry=0;
            
            turn.weather.nextHotCold=0;
        
        }
    else
        if (weather == @"Hot") {
            turn.weather.nextHotCold =0;
        }
    else
        if (weather ==@"Cold") {
            turn.weather.nextHotCold =1;
        }
    else
        if (weather ==@"Wet") {
            turn.weather.nextWetDry =0;
        }
    else 
        if (weather ==@"Dry") {
            turn.weather.nextWetDry =1;
        }
    else 
        if (weather ==@"Toggle") {
            
            turn.weather.nextHotCold = ! turn.weather.HotCold;
            
            turn.weather.nextWetDry = ! turn.weather.WetDry;
        }


}

@end
