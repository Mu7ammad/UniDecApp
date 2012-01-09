//
//  Profile.m
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "Profile.h"

@implementation Profile
@synthesize cardLibrary,cardPanelNames,power;

static Profile *myProfile = nil;

+(Profile *)sharedInstance{
    
    if (!myProfile) {
        myProfile = [[Profile alloc]init];
    }
    
    return myProfile;
}



-(id)init{
    
    self = [super init];
    
    power = [[Power alloc]init];
    
    //load CardLibrary
    NSString *path = [[NSBundle mainBundle] bundlePath];
	
	NSString *finalPath = [path stringByAppendingPathComponent:@"CardLibrary.plist"];
	
	cardLibrary = [NSDictionary dictionaryWithContentsOfFile:finalPath];
    
    
    
    // specify card names used in panel
    cardPanelNames = [NSArray arrayWithObjects:@"Fire Attack",@"Fire Defense", @"Fire Rest",@"Water Attack",@"Water Defense",@"Water Rest",@"Air Attack", nil];

    
    
    return self;
}


@end
