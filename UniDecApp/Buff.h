//
//  Buff.h
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Turn.h"

@interface Buff : NSObject
{
    bool target;

}

-(void) applyBuff:(Turn*) turn;

@end
