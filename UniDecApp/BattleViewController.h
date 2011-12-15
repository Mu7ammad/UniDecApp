//
//  ViewController.h
//  UniDecApp
//
//  Created by Muhammad Hilal on 12/14/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardPanel.h"


@interface BattleViewController : UIViewController

{   
    
    CardPanel* cardPanel;
    
}

@property (weak, nonatomic) IBOutlet UIView *BackgroundView;
@property (weak, nonatomic) IBOutlet UIView *CardPanelView;

@property (weak, nonatomic) IBOutlet UIImageView *card1;
@property (weak, nonatomic) IBOutlet UIImageView *card2;
@property (weak, nonatomic) IBOutlet UIImageView *card3;
@property (weak, nonatomic) IBOutlet UIImageView *card4;
@property (weak, nonatomic) IBOutlet UIImageView *card5;
@property (weak, nonatomic) IBOutlet UIImageView *card6;
@property (weak, nonatomic) IBOutlet UIImageView *card7;

@property (weak, nonatomic) IBOutlet UIImageView *SelectedCard;

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *UpSwipeSelectGest;

- (IBAction)RightSwipeAction:(id)sender;
- (IBAction)LeftSwipeAction:(id)sender;
- (IBAction)TapAction:(id)sender;
- (IBAction)UpSwipeSelectAction:(id)sender;

- (IBAction)BackgroundTapAction:(id)sender;


@end
