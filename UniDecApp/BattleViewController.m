//
//  ViewController.m
//  UniDecApp
//
//  Created by Muhammad Hilal on 12/14/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "BattleViewController.h"

@implementation BattleViewController

@synthesize UpSwipeSelectGest;

@synthesize BackgroundView;
@synthesize CardPanelView;
@synthesize myCharge;
@synthesize hisCharge;
@synthesize currentWeather;

@synthesize card1;
@synthesize card2;
@synthesize card3;
@synthesize card4;
@synthesize card5;
@synthesize card6;
@synthesize card7;
@synthesize SelectedCard;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //load CardLibrary
    NSString *path = [[NSBundle mainBundle] bundlePath];
	
	NSString *finalPath = [path stringByAppendingPathComponent:@"CardLibrary.plist"];
	
	NSDictionary* CardLibrary = [NSDictionary dictionaryWithContentsOfFile:finalPath];
    
    // specify card names used in panel
    NSArray* cardNames = [NSArray arrayWithObjects:@"Fire Attack", nil];
    
    //init card panel 
    cardPanel = [[CardPanel alloc]init:cardNames from:CardLibrary];
        
    
    //take UIViews
    cardPanel.PanelView = CardPanelView;
    
    [cardPanel takeCardViews:[NSArray arrayWithObjects:card1,card2,card3,card4,card5,card6,card7, nil] and:SelectedCard];
    
    //init turn and connect to UI 
    turn = [[Turn alloc]init];
    
    turn.chargeMeter.myCharge = myCharge;
    turn.chargeMeter.hisCharge = hisCharge;
    turn.weather.currentWeather = currentWeather;
        
    if (initiator) {
    
        [self playFirstTurn];
    }
    else
    {
      
       [self   playTurn];
      
    }
    
}


-(void) playFirstTurn
{


}

-(void)playTurn
{
    
    
    
    
    
    
    //buff the turn
    for (Buff* buff in buffs) {
        [buff applyBuff:turn];
    }

    



}

- (void)viewDidUnload
{
    [self setCard1:nil];
    [self setCard2:nil];
    [self setCard3:nil];
    [self setCard4:nil];
    [self setCard5:nil];
    [self setView:nil];
    
    [self setCard6:nil];
    [self setCard7:nil];
    [self setUpSwipeSelectGest:nil];
    
    [self setSelectedCard:nil];
    [self setMyCharge:nil];
    [self setHisCharge:nil];
    [self setCurrentWeather:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}




- (IBAction)RightSwipeAction:(id)sender {
    
    [cardPanel PushRight];    
}

- (IBAction)LeftSwipeAction:(id)sender {
    
    [cardPanel PushLeft];    
}

- (IBAction)TapAction:(id)sender {
    
    [cardPanel PullUp];
    
}

- (IBAction)UpSwipeSelectAction:(id)sender {
    
   
        
        int x = [UpSwipeSelectGest locationInView:CardPanelView].x;
        
        if(x>224 && x<544) //action on center card
        {
        
            [cardPanel SelectCard];
            
        }
    
    
}

- (IBAction)BackgroundTapAction:(id)sender {
    
    [cardPanel PushDown];
}

@end
