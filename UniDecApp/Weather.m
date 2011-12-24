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
            HotCold =0; WetDry=0;
            break;
            case 2://Winter
            HotCold=1; WetDry=0;
            break;
            case 3://Summer
            HotCold=0; WetDry=1;
            break;
            case 4://Autmn
            HotCold=1; WetDry=1;
            break;
            
            
        default://random
            rand = arc4random()%4;
            switch (rand) {
                case 0:
                    HotCold =0; WetDry=0;
                    break;
                case 1:
                    HotCold =1; WetDry =0;
                    break;
                case 2:
                    HotCold =0; WetDry =1;
                    break;
                case 3:
                    HotCold=1; WetDry=1;
                    break;
                default:
                    break;
            }
            
            break;
    }

    [self presentWeatehr];
}

@end
