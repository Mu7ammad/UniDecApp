//
//  Card.h
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
{
    
    NSString* name;
    
    NSDictionary* data;
    
    int rank; //how rare it is
    
    int element; //1,2,3,4
    
}

@property (weak, nonatomic) UIImageView* view;

-(NSArray*) generateBuffs;

-(bool) checkCondition: (int) weatehr;


-(void) ScaleUpToLeft;
-(void) ScaleDownToLeft;
-(void) ScaleUpToRight;
-(void) ScaleDownToRight;


@end
