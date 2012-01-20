//
//  Move.h
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Move : NSObject

@property int magnitude;
@property bool target;// 0 my move, 1 op move

-(Move*) winAgainst: (Move*) otherMove;
@end