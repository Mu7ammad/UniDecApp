//
//  MoveBuff.h
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "Buff.h"

//affect player
@interface MoveBuff : Buff
{

    NSString* move;
}

-(id)init:(NSString*)Move;

@end
