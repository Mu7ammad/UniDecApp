//
//  Card.m
//  UniDecApp
//
//  Created by Muhammad Hilal on 12/14/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "Card.h"

@implementation Card

@synthesize view;


-(void)ScaleUpToLeft
{

    
    
    CGPoint center = CGPointMake(view.center.x -128, view.center.y);
    
    view.center = center;
    
    CGRect bounds = CGRectMake(0, 0, view.bounds.size.width*1.33334, view.bounds.size.height *1.33334);
    
    
    view.bounds = bounds;

}

-(void)ScaleDownToLeft
{

    
    
    CGPoint center = CGPointMake(view.center.x -128, view.center.y);
    
    view.center = center;
    
    CGRect bounds = CGRectMake(0, 0, view.bounds.size.width*0.75, view.bounds.size.height *0.75);
    
    
    view.bounds = bounds;

}

-(void)ScaleUpToRight
{
    
    
    CGPoint center = CGPointMake(view.center.x +128, view.center.y);
    
    view.center = center;
    
    CGRect bounds = CGRectMake(0, 0, view.bounds.size.width*1.33334, view.bounds.size.height *1.33334);
    
    
    view.bounds = bounds;



}

-(void)ScaleDownToRight
{
    
    
    CGPoint center = CGPointMake(view.center.x +128, view.center.y);
    
    view.center = center;
    
    CGRect bounds = CGRectMake(0, 0, view.bounds.size.width*0.75, view.bounds.size.height *0.75);
    
    
    view.bounds = bounds;

}

@end
