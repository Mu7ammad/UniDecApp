//
//  ViewController.h
//  UniDecApp
//
//  Created by Muhammad Hilal on 12/14/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardPanel.h"
#import "Buff.h"
#import "Turn.h"

@interface BattleViewController : UIViewController

{   
    CardPanel* cardPanel;
    
    NSMutableArray* buffs;
      
    Turn* turn;
        
    bool end;
    bool myTurn;
    
    bool initiator;//wheather I'm the one who initiated the Battle
}

@property (weak, nonatomic) IBOutlet UIView *BackgroundView;
@property (weak, nonatomic) IBOutlet UIView *CardPanelView;

//to be replaced with proper UI elements
@property (weak, nonatomic) IBOutlet UILabel *myCharge;
@property (weak, nonatomic) IBOutlet UILabel *hisCharge;
@property (weak, nonatomic) IBOutlet UILabel *currentWeather;
//

@property (weak, nonatomic) IBOutlet UIImageView *card1;
@property (weak, nonatomic) IBOutlet UIImageView *card2;
@property (weak, nonatomic) IBOutlet UIImageView *card3;
@property (weak, nonatomic) IBOutlet UIImageView *card4;
@property (weak, nonatomic) IBOutlet UIImageView *card5;
@property (weak, nonatomic) IBOutlet UIImageView *card6;
@property (weak, nonatomic) IBOutlet UIImageView *card7;

@property (weak, nonatomic) IBOutlet UIImageView *SelectedCard;

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *UpSwipeSelectGest;


-(void) playTurn;
-(void) playFirstTurn;

- (IBAction)RightSwipeAction:(id)sender;
- (IBAction)LeftSwipeAction:(id)sender;
- (IBAction)TapAction:(id)sender;
- (IBAction)UpSwipeSelectAction:(id)sender;
- (IBAction)BackgroundTapAction:(id)sender;

@end