//
//  Profile.h
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Power.h"

@interface Profile : NSObject
{
    NSString* name;
    int charge;
    int level;
    
}

@property (readonly, strong) NSDictionary* cardLibrary;
@property (readwrite, strong) NSArray* cardPanelNames;
@property (readonly, strong) Power* power;

+(Profile*) sharedInstance;

@end
