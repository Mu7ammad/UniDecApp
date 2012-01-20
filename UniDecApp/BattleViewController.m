//
//  ViewController.m
//  UniDecApp
//
//  Created by Muhammad Hilal on 12/14/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "BattleViewController.h"


@implementation BattleViewController
@synthesize SegmentedPanel;
@synthesize myChargeLabel_iPod;
@synthesize hisChargeLabel_iPod;
@synthesize currentWeatherLabel_iPod;

@synthesize UpSwipeSelectGest;

@synthesize BackgroundView;
@synthesize CardPanelView;
@synthesize myChargeLabel;
@synthesize hisChargeLabel;
@synthesize currentWeatherLabel;

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
    [self setCurrentWeatherLabel:nil];
    [self setSegmentedPanel:nil];
    [self setMyChargeLabel_iPod:nil];
    [self setHisChargeLabel_iPod:nil];
    [self setCurrentWeatherLabel_iPod:nil];
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
    
    
    //present MatchMaker ViewController
    [[GCTurnBasedMatchHelper sharedInstance] findMatchWithMinPlayers:2 maxPlayers:2 viewController:self];
    

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
        
            
           playedCard = [cardPanel SelectCard];
            
            //sending the turn
            [self sendTurn];
            
        }
    
}



- (IBAction)SegmentSelectAction:(id)sender {

    
    
    playedCard = [cardPanel SelectCardNo:SegmentedPanel.selectedSegmentIndex];
    
    //sending the turn
    [self sendTurn];
    
}


- (IBAction)BackgroundTapAction:(id)sender {
    
    [cardPanel PushDown];
}



-(void)presentTurnWithData:(NSDictionary *)data{
    
    
    
    NSNumber* num = [data objectForKey:@"turnNo"];
    int turnNo = [num intValue];
    num = nil;
    
    //init card panel      
    
    if (turnNo>1) {//load from data, skip turn 0, 1
        
        cardPanel = [[CardPanel alloc]init:[data objectForKey:@"myCardNames"] from:[Profile sharedInstance].cardLibrary];
        
    } else {//load from profile
        
        
        cardPanel = [[CardPanel alloc]init:[Profile sharedInstance].cardPanelNames from:[Profile sharedInstance].cardLibrary];
                
    }
    
    //save opponent card panel for him
    opCardNamesDeposit = [data objectForKey:@"opCardNames"];
    
    
    
    
    //init played cards
    if (turnNo%2) {//odd
        NSString* myPre = [data objectForKey:@"myPrePlayedCardName"];
        myPrePlayedCard = [[Card alloc] init:myPre from:[Profile sharedInstance].cardLibrary];
        
        NSString* opPre = [data objectForKey:@"opPrePlayedCardName"];
        opPrePlayedCard = [[Card alloc] init:opPre from:[Profile sharedInstance].cardLibrary];
        
        
    }
    else{//even
        
        NSString* opPl = [data objectForKey:@"opPlayedCardName"];
        opPlayedCard = [[Card alloc]init:opPl from:[Profile sharedInstance].cardLibrary];
        
        if (turn.turnNo>0) {
            
            NSString* myPre = [data objectForKey:@"myPrePlayedCardName"];
            myPrePlayedCard = [[Card alloc] init:myPre from:[Profile sharedInstance].cardLibrary];
            
            NSString* opPre = [data objectForKey:@"opPrePlayedCardName"];
            opPrePlayedCard = [[Card alloc] init:opPre from:[Profile sharedInstance].cardLibrary];
            

            
        }
        
    }
    
    
    //init turn
    turn = [[Turn alloc]initWithTurnData:data];
    
    
    
    //connect UI
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // The device is an iPad 
        
        //take UIViews
        cardPanel.PanelView = CardPanelView;
        
        [cardPanel takeCardViews:[NSArray arrayWithObjects:card1,card2,card3,card4,card5,card6,card7, nil] and:SelectedCard];
        
               
        turn.chargeMeter.myChargeLabel = myChargeLabel;
        turn.chargeMeter.opChargeLabel = hisChargeLabel;
        [turn.chargeMeter presentCharge];
        
        turn.weather.currentWeatherLabel = currentWeatherLabel;
        [turn.weather presentWeatehr];
        
    }
    else {
        // The device is an iPhone or iPod touch.
        
        turn.chargeMeter.myChargeLabel = myChargeLabel_iPod;
        turn.chargeMeter.opChargeLabel = hisChargeLabel_iPod;
        turn.weather.currentWeatherLabel = currentWeatherLabel_iPod;
        
    }
    
}

-(void)playTurnWith:(Card *)myCard :(Card *)hisCard{
    
    buffs = [[NSMutableArray alloc]init];
    
    [buffs addObjectsFromArray:[myCard generateBuffs]];
    [buffs addObjectsFromArray:[hisCard generateBuffs]];
    
    //the turn is buffed
    for (Buff *buff in buffs) {
        
        [buff applyBuff:turn];
        
    }
        
    [turn evaluateTurn];
}


-(NSData *)encodeTurn
{
    
    NSMutableArray* objects = [[NSMutableArray alloc]init];
    NSMutableArray* keys = [[NSMutableArray alloc]init];
    
    //I'm becoming opponent !
      
    //increment the turnNo you send
    NSNumber* turnNo = [NSNumber numberWithInt:turn.turnNo++];
    int x = [turnNo intValue];
    [objects addObject:turnNo];
    [keys addObject:@"turnNo"];

    
  
        if (turn.turnNo%2) {//odd, to be sent to me again, 2 cards
       
        NSString* myPrePlayedCardName = playedCard.name;
        [objects addObject:myPrePlayedCardName];
        [keys addObject:@"myPrePlayedCardName"];
            
                        
        NSString* opPrePlayedCardName = opPlayedCard.name;
        [objects addObject:opPrePlayedCardName];
        [keys addObject:@"opPrePlayedCardName"];
            
            
        } else {//even, to be sent to op, 3 cards (1 at start)
                        
            NSString* opPlayedCardName = playedCard.name;
            [objects addObject:opPlayedCardName];
            [keys addObject:@"opPlayedCardName"];
            
            if (turn.turnNo>0) {
                NSString* myPrePlayedCardName = opPrePlayedCard.name;
                [objects addObject:myPrePlayedCardName];
                [keys addObject:@"myPrePlayedCardName"];
                
                
                NSString* opPrePlayedCardName = myPrePlayedCard.name;
                [objects addObject:opPrePlayedCardName];
                [keys addObject:@"opPrePlayedCardName"];
                
            }
        }
    
    if (turn.turnNo>0) {//we now about the op player
        
        NSArray* myCardNames = opCardNamesDeposit;
        [objects addObject:myCardNames];
        [keys addObject:@"myCardNames"];
        
        
        NSNumber* myCharge = [NSNumber numberWithInt:turn.chargeMeter.opCharge];
        [objects addObject:myCharge];
        [keys addObject:@"myCharge"];
        
    }
        
    
    //weather
    NSNumber* HotCold = [NSNumber numberWithBool:turn.weather.nextHotCold];
    [objects addObject:HotCold];
    [keys addObject:@"HotCold"];
    
    NSNumber* WetDry = [NSNumber numberWithBool:turn.weather.nextWetDry];
    [objects addObject:WetDry];
    [keys addObject:@"WetDry"];
    

    
    //opponent
    NSArray* opCardNames = [cardPanel getCardNames];
    [objects addObject:opCardNames];
    [keys addObject:@"opCardNames"];
    
        
    NSNumber* opCharge =[NSNumber numberWithInt:turn.chargeMeter.myCharge];
    int y = [opCharge intValue];
    [objects addObject:opCharge];
    [keys addObject:@"opCharge"];
    
    
    NSNumber* opAttackPower = [NSNumber numberWithInt:[Profile sharedInstance].power.attackPower];
    int z = [opAttackPower intValue];
    [objects addObject:opAttackPower];
    [keys addObject:@"opAttackPower"];
    
    NSNumber* opDefensePower = [NSNumber numberWithInt:[Profile sharedInstance].power.defensePower];
    [objects addObject:opDefensePower];
    [keys addObject:@"opDefensePower"];
    
    NSNumber* opRestPower = [NSNumber numberWithInt:[Profile sharedInstance].power.restPower];
    [objects addObject:opRestPower];
    [keys addObject:@"opRestPower"];
    
        
    NSDictionary* turnData = [[NSDictionary alloc]initWithObjects:objects forKeys:keys];
    

    
    NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	[archiver encodeObject:turnData forKey:@"turnData"];
    [archiver finishEncoding];
	
    return [[NSData alloc]initWithData:data];
    
}

-(void)sendTurn{
    
    //send NSData object of the turn
    
    
    NSData* turnData = [self encodeTurn];
    
    //get match
    GKTurnBasedMatch *currentMatch = 
    [[GCTurnBasedMatchHelper sharedInstance] currentMatch];
    
        
    
    NSUInteger currentIndex = [currentMatch.participants 
                               indexOfObject:currentMatch.currentParticipant];
    GKTurnBasedParticipant *nextParticipant;
    
    //choosing next participant
    if (turn.turnNo%2) {//odd, to be sent to me again
        
        
        nextParticipant = currentMatch.currentParticipant;
        
    } else {//even, to be sent to op
        
        NSUInteger nextIndex = (currentIndex + 1) % [currentMatch.participants count];
        nextParticipant = [currentMatch.participants objectAtIndex:nextIndex];
        
        
    }
    
    /*
    for (int i = 0; i < [currentMatch.participants count]; i++) {
        
         nextParticipant = [currentMatch.participants 
                           objectAtIndex:((currentIndex + 1 + i) % 
                                          [currentMatch.participants count ])];
        
         if (nextParticipant.matchOutcome != GKTurnBasedMatchOutcomeQuit) {
            break;
        } 
    } */   
    
    
    //make sure you don't send the turn to someone who quit

    if (nextParticipant.matchOutcome != GKTurnBasedMatchOutcomeQuit) {
        
        [currentMatch endTurnWithNextParticipant:nextParticipant matchData:turnData completionHandler:^(NSError *error) {
            
            if (error) {
                NSLog(@"%@", error);
            }
        }];
    } 
    else{
        //******
    }
       
    
    NSLog(@"Send Turn, %@, %@", turnData, nextParticipant);
    
}

#pragma mark - GCTurnBasedMatchHelperDelegate

-(void) enterNewGame:(GKTurnBasedMatch *)match{
    
    NSLog(@"Entering new game...");
    
    // prepare new game (seed the data with turn 0 
    
    NSNumber* turnNo =[NSNumber numberWithInt:0];
    
    NSArray* objects = [[NSArray alloc]initWithObjects:turnNo, nil];
    NSArray* keys = [[NSArray alloc]initWithObjects:@"turnNo",nil];
    
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
    
    
    //unpack data
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:match.matchData];
    
    NSDictionary *turnData = [unarchiver decodeObjectForKey:@"turnData"];
    [unarchiver finishDecoding];

    [self presentTurnWithData:turnData];
    
    // ....
}


-(void)takeTurn:(GKTurnBasedMatch *)match{
    
    NSLog(@"Taking turn for existing game...");
    
    //prepare to continue game
    
    
    //check if it's my first time in this game ##
    
    
    
    //unpack data
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:match.matchData];
    
    NSDictionary *turnData = [unarchiver decodeObjectForKey:@"turnData"];
    [unarchiver finishDecoding];
    
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
