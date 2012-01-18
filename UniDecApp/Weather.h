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

@property bool HotCold, WetDry;//0 hot or wet, 1 cold or dry

@property (nonatomic) bool nextHotCold, nextWetDry;

@property bool controlledTemp;
@property bool controlledHumid;

@property int seasonCounter;

@property (weak, nonatomic) UILabel *currentWeatherLabel;

-(void) presentWeatehr;

-(void) takeIndicator:(UILabel *)weatherLabel;

@end
