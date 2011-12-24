//
//  MoveProb.h
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoveProb : NSObject

@property int mode; // 
@property int suggestedMove;//0 attack -- 1 defese -- 2 rest

-(int) decideMove;


@end
