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

#import "GCTurnBasedMatchHelper.h"

@interface BattleViewController : UIViewController <GCTurnBasedMatchHelperDelegate>

{   
    CardPanel* cardPanel;
    
    NSMutableArray* buffs;
      
    Turn* turn;
    
    Card* playedCard;
    
    NSArray* hisCardNamesDeposit;
}

@property (weak, nonatomic) IBOutlet UIView *BackgroundView;
@property (weak, nonatomic) IBOutlet UIView *CardPanelView;

//to be replaced with proper UI elements
@property (weak, nonatomic) IBOutlet UILabel *myChargeLabel;
@property (weak, nonatomic) IBOutlet UILabel *hisChargeLabel;
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



- (IBAction)RightSwipeAction:(id)sender;
- (IBAction)LeftSwipeAction:(id)sender;
- (IBAction)TapAction:(id)sender;
- (IBAction)UpSwipeSelectAction:(id)sender;
- (IBAction)BackgroundTapAction:(id)sender;


-(void) presentTurnWithData:(NSDictionary*) data;

-(NSData*) encodeTurn;

-(void) sendTurn;


@end