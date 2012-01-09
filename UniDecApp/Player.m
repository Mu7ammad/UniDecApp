//
//  Player.m
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "Player.h"

@implementation Player
@synthesize power, prob, target;

-(id)init{
    
    self = [super init];
    
    power= [[Power alloc]init];
    prob= [[MoveProb alloc]init];
    
    return self;
}

-(Move *)makeMove
{

    Move* move; 
    switch([prob decideMove])
    {
            case 0://attack
    
            move = [[AttackMove alloc]init];
            move. magnitude = [power givePowerforMove:0];
            
            
            break;
            case 1://defense
                
            move = [[DefenseMove alloc]init];
            move. magnitude = [power givePowerforMove:1];
            
            break;
            
            case 2://rest
            move = [[RestMove alloc]init];
            move. magnitude = [power givePowerforMove:2];
            
            break;
    
    }
    
    //reset power
    power.ampMode =0;
    
    
    //reset move prob
    prob.mode =0;
    
                    
            
    
    move.target =target;
    
    return move;

}
@end
