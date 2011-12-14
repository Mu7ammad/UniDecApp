//
//  ViewController.h
//  UniDecApp
//
//  Created by Muhammad Hilal on 12/14/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BattleViewController : UIViewController

{   
    NSMutableArray* Cards;    
    
    int centerCard;
    
    bool Paneldown;
}

@property (weak, nonatomic) IBOutlet UIView *Background;
@property (weak, nonatomic) IBOutlet UIView *CardPanel;

@property (weak, nonatomic) IBOutlet UIImageView *card1;
@property (weak, nonatomic) IBOutlet UIImageView *card2;
@property (weak, nonatomic) IBOutlet UIImageView *card3;
@property (weak, nonatomic) IBOutlet UIImageView *card4;
@property (weak, nonatomic) IBOutlet UIImageView *card5;
@property (weak, nonatomic) IBOutlet UIImageView *card6;
@property (weak, nonatomic) IBOutlet UIImageView *card7;

@property (weak, nonatomic) IBOutlet UIImageView *SelectedCard;

-(void) ScaleUpToLeft:(UIImageView*) card;
-(void) ScaleDownToLeft:(UIImageView*) card;
-(void) ScaleUpToRight:(UIImageView*) card;
-(void) ScaleDownToRight:(UIImageView*) card;

-(void) ElasticReboundToRight;
-(void) ElasticReboundToLeft;
-(void) PushCardPanelLeft;
-(void) PushCardPanelRight;
-(void) PushCardPanelDown;
-(void) PullCardPanelUp;

@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *UpSwipeSelectGest;

- (IBAction)RightSwipeAction:(id)sender;
- (IBAction)LeftSwipeAction:(id)sender;
- (IBAction)TapAction:(id)sender;
- (IBAction)UpSwipeSelectAction:(id)sender;

- (IBAction)BackgroundTapAction:(id)sender;


@end
