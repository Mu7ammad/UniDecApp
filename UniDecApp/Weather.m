//
//  Weather.m
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "Weather.h"

@implementation Weather

@synthesize HotCold,WetDry,seasonCounter, currentWeatherLabel, controlledTemp, controlledHumid;

@synthesize nextHotCold = _nextHotCold;
@synthesize nextWetDry = _nextWetDry;

-(void)takeIndicator:(UILabel *)weatherLabel
{
    currentWeatherLabel = weatherLabel;

}

//setter
-(void)setNextHotCold:(_Bool)nextHotCold{
    
    _nextHotCold = nextHotCold;
    
    controlledTemp= 1;
    
    
}
//getter
-(_Bool)getNextHotCold{
    
    if (!controlledTemp) {
        _nextHotCold = arc4random()%2;
    }
    
    return _nextHotCold;
}


//setter
-(void)setNextWetDry:(_Bool)nextWetDry{
    
    _nextWetDry = nextWetDry;
    
    controlledHumid =1;
}

//getter
-(_Bool)getNextWetDry{
    
    if (!controlledHumid) {
        _nextWetDry = arc4random()%2;
    }
    
    return _nextWetDry;
}

-(void)presentWeatehr
{
    //indicate the current weatehr
    
    if (HotCold == 0 && WetDry == 0) {//hot and wet ->air
        
        currentWeatherLabel.text = @"Spring - Hot and Wet";
    }
    else
        if (HotCold == 1 && WetDry == 0) {//cold and wet ->water
            
            currentWeatherLabel.text = @"Winter - Cold and Wet";
        }
    else
        if (HotCold == 0 && WetDry == 1) {//hot and dry ->fire
            
            currentWeatherLabel.text = @"Summer - Hot and Dry";
        }
    else
        if (HotCold == 1 && WetDry == 1) {//cold and dry ->earth
            
            currentWeatherLabel.text = @"Autumn - Cold and Dry";
        }
    
}


@end
