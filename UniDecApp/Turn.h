//
//  Turn.h
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "Move.h"
#import "Player.h"
#import "Weather.h"
#import "ChargeMeter.h"


@interface Turn : NSObject


@property (strong) Player* myPlayer;
@property (strong) Player* hisPlayer;
@property (strong) Weather* weather;
@property (strong) ChargeMeter* chargeMeter;

@property (strong) Move* myMove; 

@property (strong) Move* hisMove;

@property int turnNo;


-(id)initWithTurnData:(NSDictionary*) data;

//makes my and his moves ready
-(void) evaluateTurn;


@end
