//
//  MoveBuff.m
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "MoveBuff.h"

@implementation MoveBuff

-(id)init:(NSString *)Move
{

    if (Move) {
        
    self = [super init];
    
    move = [NSString stringWithFormat:Move];
    
    return self;
    }
    
    else
    {
        return nil;
    
    }
}

-(void)applyBuff:(Turn *)turn
{
    

    if (move == @"Attack") 
    {
        
        if (target) {
        turn.opPlayer.prob.suggestedMove =0;    
        }
        else
        {
        turn.myPlayer.prob.suggestedMove =0;
        }
        
    }
    else if (move == @"Defense")
    {
        if (target) {
        turn.opPlayer.prob.suggestedMove =1;
        }
        else
        {        
        turn.myPlayer.prob.suggestedMove =1;
        }
        
    }
    else if (move ==@"Rest")
    {
        if (target) {
        turn.opPlayer.prob.suggestedMove =2;    
        }
        else
        {
        turn.myPlayer.prob.suggestedMove =2;
        }
    }
    
    

}

@end
