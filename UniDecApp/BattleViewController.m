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

    //present MatchMaker ViewController
    [[GCTurnBasedMatchHelper sharedInstance] findMatchWithMinPlayers:2 maxPlayers:2 viewController:self];

            
  
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
        turn.weather.currentWeather = currentWeatherLabel;
        
    }
    else {
        // The device is an iPhone or iPod touch.
        
        turn.chargeMeter.myChargeLabel = myChargeLabel_iPod;
        turn.chargeMeter.hisChargeLabel = hisChargeLabel_iPod;
        turn.weather.currentWeather = currentWeatherLabel_iPod;
        
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
    
    //take moves and affect ChargeMeter
    [turn.myPlayer makeMove];
    
    [turn.hisPlayer makeMove];
    
}


-(NSData *)encodeTurn
{
    
    //13 items
    NSString* playedCardName = playedCard.name;
    // card2
    NSArray* myCardNames = [cardPanel getCardNames];
    NSArray* hisCardNames = hisCardNamesDeposit;
    
    //weather 1
    //weather 2
    
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
    
    
    NSData* turnData = [self encodeTurn];
    
    //get match
    GKTurnBasedMatch *currentMatch = 
    [[GCTurnBasedMatchHelper sharedInstance] currentMatch];
    
        
    
    NSUInteger currentIndex = [currentMatch.participants 
                               indexOfObject:currentMatch.currentParticipant];
    GKTurnBasedParticipant *nextParticipant;
    
    NSUInteger nextIndex = (currentIndex + 1) % 
    [currentMatch.participants count];
    nextParticipant = 
    [currentMatch.participants objectAtIndex:nextIndex];
    
    
    //make sure you don't send the turn to someone who quit
    for (int i = 0; i < [currentMatch.participants count]; i++) {
        nextParticipant = [currentMatch.participants 
                           objectAtIndex:((currentIndex + 1 + i) % 
                                          [currentMatch.participants count ])];
        if (nextParticipant.matchOutcome != 
            GKTurnBasedMatchOutcomeQuit) {
            break;
        } 
    }    
    
    
    [currentMatch endTurnWithNextParticipant:nextParticipant matchData:turnData completionHandler:^(NSError *error) {
        
        if (error) {
            NSLog(@"%@", error);
        }
    }];
    
    NSLog(@"Send Turn, %@, %@", turnData, nextParticipant);
    
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
    
    
    //unpack data
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:match.matchData];
    
    NSDictionary *turnData = [unarchiver decodeObjectForKey:@"turnData"];
    [unarchiver finishDecoding];

    //present turn
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
    
    //present turn
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
