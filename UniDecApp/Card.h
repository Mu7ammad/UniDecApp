//
//  Card.h
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ElementBuff.h"
#import "MoveBuff.h"
#import "WeatherBuff.h"
#import "TurnBuff.h"

@interface Card : NSObject
{
    
    NSDictionary* data;
    
}

@property (weak, nonatomic) UIImageView* view;
@property (strong) NSString* name;


-(NSArray*) generateBuffs;

-(id)init:(NSString*)cardName from:(NSDictionary*) CardLibrary;

-(void) ScaleUpToLeft;
-(void) ScaleDownToLeft;
-(void) ScaleUpToRight;
-(void) ScaleDownToRight;


@end
