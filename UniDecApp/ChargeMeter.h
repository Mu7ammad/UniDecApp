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
{
    int c , boundary;
}

@property (weak, nonatomic)  UILabel *myCharge;
@property (weak, nonatomic)  UILabel *hisCharge;

@end
