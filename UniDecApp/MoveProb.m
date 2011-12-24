//
//  MoveProb.m
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "MoveProb.h"

@implementation MoveProb
@synthesize mode, suggestedMove;


-(int)decideMove
{
    int  move;
    
    switch (mode) {
        
                    
        case 1:// 75% for suggested move
            
            move = arc4random()%4;
            
            if (rand ==0)//25% prob 
            {
                //choose one of the other 2 moves equally                
                move = suggestedMove;
                while (move == suggestedMove)
                {
                    move = arc4random()%3;
                }
                
            }
            else //75% prob
            {
                move = suggestedMove;
            
            }
            
            
        break;
            
        case 2:
            
            move = arc4random()%2;
            
            if (rand ==0)//50% prob 
            {
                //choose one of the other 2 moves equally                
                move = suggestedMove;
                while (move == suggestedMove)
                {
                    move = arc4random()%3;
                }
                
            }
            else //50% prob
            {
                move = suggestedMove;
                
            }


        
            break;
          
        case 3://random move
        
            move = arc4random()%3;
            
            break;
            
        default://100% suggested move
            
            move = suggestedMove;
            
            
            break;
    }

    return move;


}


@end
