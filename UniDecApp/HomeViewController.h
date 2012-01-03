//
//  HomeViewController.h
//  UniDecApp
//
//  Created by Muhammad Hilal on 12/30/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCTurnBasedMatchHelper.h"


@interface HomeViewController : UIViewController

-(void) presentGCTurnViewController;


- (IBAction)presentGCTurnViewController_iPod:(id)sender;
- (IBAction)presentGCTurnViewController_iPad:(id)sender;

@end
