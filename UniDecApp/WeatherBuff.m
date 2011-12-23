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

@end
