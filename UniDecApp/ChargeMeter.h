//
//  Charge.h
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <Foundation/Foundation.h>


//connect to UI

@interface ChargeMeter : NSObject

@property (weak, nonatomic)  UILabel *myChargeLabel;
@property (weak, nonatomic)  UILabel *opChargeLabel;
@property int myCharge, opCharge;
@property bool opUnavailable;

-(void) presentCharge;
@end
