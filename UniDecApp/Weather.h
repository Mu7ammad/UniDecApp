//
//  Weather.h
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <Foundation/Foundation.h>

//connect to UI

@interface Weather : NSObject
    
@property bool HotCold, WetDry;

@property bool nextHotCold, nextWetDry;

@property int seasonCounter;

@property (weak, nonatomic) UILabel *currentWeather;


@end
