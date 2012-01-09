//
//  Power.h
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Power : NSObject
{
    
}

@property int ampMode;//amplification mode
@property int attackPower, defensePower, restPower;

-(int) givePowerforMove:(int) move;

@end
