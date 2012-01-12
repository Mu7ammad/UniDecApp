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
#import "Profile.h"
#import "GCTurnBasedMatchHelper.h"

@interface BattleViewController : UIViewController <GCTurnBasedMatchHelperDelegate>

{   
    CardPanel* cardPanel;
    
    Card* playedCard;
    
    NSMutableArray* buffs;
      
    Turn* turn;
    
    NSArray* opCardNamesDeposit;
    
    bool newGame;
    bool myTurn;
    bool secondPhase;
    
}


//iPad UI elements

@property (weak, nonatomic) IBOutlet UIView *BackgroundView;
@property (weak, nonatomic) IBOutlet UIView *CardPanelView;


//to be replaced with proper UI elements
@property (weak, nonatomic) IBOutlet UILabel *myChargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *hisChargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentWeatherLabel;
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


- (IBAction)RightSwipeAction:(id)sender;
- (IBAction)LeftSwipeAction:(id)sender;
- (IBAction)TapAction:(id)sender;
- (IBAction)BackgroundTapAction:(id)sender;

- (IBAction)UpSwipeSelectAction:(id)sender;

//iPod UI elements

@property (weak, nonatomic) IBOutlet UISegmentedControl *SegmentedPanel;

@property (weak, nonatomic) IBOutlet UILabel *myChargeLabel_iPod;
@property (weak, nonatomic) IBOutlet UILabel *hisChargeLabel_iPod;
@property (weak, nonatomic) IBOutlet UILabel *currentWeatherLabel_iPod;

- (IBAction)SegmentSelectAction:(id)sender;

-(void) presentTurnWithData:(NSDictionary*) data;

-(void) playTurnWith:(Card*)myCard:(Card*)hisCard;

-(NSData*) encodeTurn;

-(void) sendTurn;

@end