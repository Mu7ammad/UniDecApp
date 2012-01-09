//
//  ViewController.m
//  UniDecApp
//
//  Created by Muhammad Hilal on 12/14/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "BattleViewController.h"
#import "Profile.h"

@implementation BattleViewController

@synthesize UpSwipeSelectGest;

@synthesize BackgroundView;
@synthesize CardPanelView;
@synthesize myChargeLabel;
@synthesize hisChargeLabel;
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
    
    [GCTurnBasedMatchHelper sharedInstance].delegate = self;
    
    
            
  
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
    [self setMyChargeLabel:nil];
    [self setHisChargeLabel:nil];
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




-(void)presentTurnWithData:(NSDictionary *)data{
    
    
    //init card panel 
    if ([data objectForKey:@"initiator"]) {
        
        
        cardPanel = [[CardPanel alloc]init:[data objectForKey:@"myCardNames"] from:[Profile sharedInstance].cardLibrary];
        
    }
    else{
        
        cardPanel = [[CardPanel alloc]init:[data objectForKey:@"hisCardNames"] from:[Profile sharedInstance].cardLibrary];
        
    }
    
    //init turn
    
    turn = [[Turn alloc]initWithTurnData:data];
    
    
    //connect UI
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // The device is an iPad 
        
        //take UIViews
        cardPanel.PanelView = CardPanelView;
        
        [cardPanel takeCardViews:[NSArray arrayWithObjects:card1,card2,card3,card4,card5,card6,card7, nil] and:SelectedCard];
        
        //init turn and connect to UI 
        turn = [[Turn alloc]init];
        
        turn.chargeMeter.myChargeLabel = myChargeLabel;
        turn.chargeMeter.hisChargeLabel = hisChargeLabel;
        turn.weather.currentWeather = currentWeather;
        
    }
    else {
        // The device is an iPhone or iPod touch.
        
    }
    
}


-(NSData *)encodeTurn
{
    
    //10 items
    NSString* playedCardName = playedCard.name;
    
    NSArray* myCardNames = [cardPanel getCardNames];
    NSArray* hisCardNames = hisCardNamesDeposit;
    
    
    bool initiator = !turn.initiator;
    
    int turnNo;
    if (initiator) {
        turnNo = turn.turnNo++;
    }else{
        
        turnNo = turn.turnNo;
    }
    
    int myCharge = turn.chargeMeter.myCharge;
    int hisCharge = turn.chargeMeter.hisCharge;
    
    int opAttackPower = [Profile sharedInstance].power.attackPower;
    
    int opDefensePower = [Profile sharedInstance].power.defensePower;
    
    int opRestPower = [Profile sharedInstance].power.restPower;
    
    
    NSArray* objects = [[NSArray alloc]initWithObjects:playedCardName, myCardNames, hisCardNames,initiator,turnNo, myCharge, hisCharge, opAttackPower, opDefensePower, opRestPower, nil];
    NSArray* keys = [[NSArray alloc]initWithObjects:@"playedCardName",@"myCardNames",@"hisCardNames",@"initiator",@"turnNo",@"myCharge",@"hisCharge",@"opAttackPower", @"opDefenesePower", @"opRestPower", nil];
    
    NSDictionary* turnData = [[NSDictionary alloc]initWithObjects:objects forKeys:keys];
    

    
    NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	[archiver encodeObject:turnData forKey:@"turnData"];
    [archiver finishEncoding];
	
    return [[NSData alloc]initWithData:data];
    
}

-(void)sendTurn{
    
    //send NSData object of the turn
    
    //make sure you don't send the turn to a participant who had quit 
    
}



#pragma mark - GCTurnBasedMatchHelperDelegate

-(void) enterNewGame:(GKTurnBasedMatch *)match{
    
    NSLog(@"Entering new game...");
    
    // prepare new game
    
        
    NSArray* myCardNames = [Profile sharedInstance].cardPanelNames;
    
    bool initiator = YES;
    
    int turnNo = 1;
    
    int myCharge = 100;
        
    
    NSArray* objects = [[NSArray alloc]initWithObjects:myCardNames,initiator,turnNo, myCharge, nil];
    NSArray* keys = [[NSArray alloc]initWithObjects:@"myCardNames",@"initiator",@"turnNo",@"myCharge",nil];
    
    NSDictionary* FirstTurnData = [[NSDictionary alloc]initWithObjects:objects forKeys:keys];
    
    
    [self presentTurnWithData:FirstTurnData];
    
    //...
}


-(void)layoutMatch:(GKTurnBasedMatch *)match{

    // view game while not my turn
    
    NSLog(@"Viewing match where it's not my turn ...");
    NSString *statusString;
    
    if (match.status == GKTurnBasedMatchStatusEnded) {
        statusString = @"Match Ended";
    } else {
        
        int playerNum = [match.participants indexOfObject:match.currentParticipant]+1;
        statusString =[NSString stringWithFormat:@"Player %d's Turn", playerNum];
    }
    
    NSDictionary* turnData = [[NSDictionary alloc]init];
    
    [self presentTurnWithData:turnData];
    
    // ....
}


-(void)takeTurn:(GKTurnBasedMatch *)match{
    
    NSLog(@"Taking turn for existing game...");
    
    //prepare to continue game
    
    
    //check if it's my first time in this game ##
    
    
    NSDictionary* turnData = [[NSDictionary alloc]init];
    
    [self presentTurnWithData:turnData];
    //....
    
        

}

-(void)sendNotice:(NSString *)notice forMatch:(GKTurnBasedMatch *)match{
    
    //another game needs your attention!
    
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Another game needs your attention!" message:notice delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [av show];
    
}


-(void)recieveEndGame:(GKTurnBasedMatch *)match{
    
    //game has ended
    
    [self layoutMatch:match];
}


@end
