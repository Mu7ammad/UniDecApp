//
//  Move.h
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChargeMeter.h"

@interface Move : NSObject

@property int magnitude;
@property bool target;

-(void) applyMove:(ChargeMeter*)chargeMeter;

@end