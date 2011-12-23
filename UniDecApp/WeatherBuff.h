//
//  WeatherBuff.h
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "Buff.h"

//affect weather
@interface WeatherBuff : Buff
{
    NSString* weather;

}
-(id)init:(NSString*)Weather;
@end
