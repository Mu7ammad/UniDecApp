//
//  Weather.m
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "Weather.h"

@implementation Weather

@synthesize HotCold,WetDry, nextWetDry, nextHotCold, seasonCounter, currentWeather;


-(void)takeIndicator:(UILabel *)Weather
{
    currentWeather = Weather;

}

-(void)presentWeatehr
{
    //indicate the current weatehr
    
    if (HotCold == 0 && WetDry == 0) {//hot and wet ->air
        
        currentWeather.text = @"Spring - Hot and Wet";
    }
    else
        if (HotCold == 1 && WetDry == 0) {//cold and wet ->water
            
            currentWeather.text = @"Winter - Cold and Wet";
        }
    else
        if (HotCold == 0 && WetDry == 1) {//hot and dry ->fire
            
            currentWeather.text = @"Summer - Hot and Dry";
        }
    else
        if (HotCold == 1 && WetDry == 1) {//cold and dry ->earth
            
            currentWeather.text = @"Autumn - Cold and Dry";
        }
    
}

-(void)changeSeason:(int)choice
{

    int rand;
    switch (choice) {
            
            case 1://Spring
            nextHotCold =0; nextWetDry=0;
            break;
            case 2://Winter
            nextHotCold=1; nextWetDry=0;
            break;
            case 3://Summer
            nextHotCold=0; nextWetDry=1;
            break;
            case 4://Autmn
            nextHotCold=1; nextWetDry=1;
            break;
            case 5://Toggle
            nextHotCold = ! HotCold;
            nextWetDry = ! WetDry;
            
            break;
            
        default://random
            rand = arc4random()%4;
            switch (rand) {
                case 0:
                    nextHotCold =0; nextWetDry=0;
                    break;
                case 1:
                    nextHotCold =1; nextWetDry =0;
                    break;
                case 2:
                    nextHotCold =0; nextWetDry =1;
                    break;
                case 3:
                    nextHotCold=1; nextWetDry=1;
                    break;
                default:
                    break;
            }
            
            break;
    }
    
    seasonCounter =0;

}

@end
