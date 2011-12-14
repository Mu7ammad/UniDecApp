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

@synthesize Background;
@synthesize CardPanel;

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
    
    SelectedCard.alpha = 0;
    
    Cards = [NSArray arrayWithObjects:card1,card2,card3,card4,card5,card6,card7, nil];
    
    for (int i = 5; i>=0; i--) {
        
        for (int j=0; j<6-i; j++) {
            
            [self ScaleDownToLeft:[Cards objectAtIndex:i]];
            
        }
    }
    
    centerCard = 6;
    
    
    for (int i =0; i<3; i++) {
        
        [self PushCardPanelRight];
        
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
    [self setCardPanel:nil];
    [self setCard6:nil];
    [self setCard7:nil];
    [self setUpSwipeSelectGest:nil];
    [self setBackground:nil];
    [self setSelectedCard:nil];
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



-(void)ScaleDownToLeft:(UIImageView *)card
{
    
    
    CGPoint center = CGPointMake(card.center.x -128, card.center.y);
    
    card.center = center;
    
    CGRect bounds = CGRectMake(0, 0, card.bounds.size.width*0.75, card.bounds.size.height *0.75);
    
    
    card.bounds = bounds;
    
    
}

-(void)ScaleUpToLeft:(UIImageView *)card
{
    
    
    
    CGPoint center = CGPointMake(card.center.x -128, card.center.y);
    
    card.center = center;
    
    CGRect bounds = CGRectMake(0, 0, card.bounds.size.width*1.33334, card.bounds.size.height *1.33334);
    
    
    card.bounds = bounds;
    
    
}

-(void)ScaleDownToRight:(UIImageView *)card

{
    
    
    CGPoint center = CGPointMake(card.center.x +128, card.center.y);
    
    card.center = center;
    
    CGRect bounds = CGRectMake(0, 0, card.bounds.size.width*0.75, card.bounds.size.height *0.75);
    
    
    card.bounds = bounds;
    
    
}


-(void)ScaleUpToRight:(UIImageView *)card
{
    
    
    CGPoint center = CGPointMake(card.center.x +128, card.center.y);
    
    card.center = center;
    
    CGRect bounds = CGRectMake(0, 0, card.bounds.size.width*1.33334, card.bounds.size.height *1.33334);
    
    
    card.bounds = bounds;
    
}


-(void) ElasticReboundToRight
{
    [UIView animateWithDuration:0.3 animations:^{
        
        for (int i =6; i>=0; i--) {
            [self ScaleDownToRight:[Cards objectAtIndex:i]];
        }
        
        
    } completion:^(BOOL finished){
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            for (int i =6; i>=0; i--){
                [self ScaleUpToLeft:[Cards objectAtIndex:i]];
            } 
            
        }];
        
    }];
    
}

-(void) ElasticReboundToLeft
{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        for (int i =6; i>=0; i--) {
            [self ScaleDownToLeft:[Cards objectAtIndex:i]];
        }
        
    }completion:^(BOOL finished){
        
        [UIView animateWithDuration:0.3 animations:^{
            for (int i =6; i>=0; i--) {
                [self ScaleUpToRight:[Cards objectAtIndex:i]];
            }
        }];
        
    }];
    
    
}


-(void)PushCardPanelRight
{
    
    if (centerCard>0) {
        
        for (int i =6; i>=0; i--) {
            
            if (i>=centerCard) {
                [self ScaleDownToRight:[Cards objectAtIndex:i]];
            }
            else 
            {
                [self ScaleUpToRight:[Cards objectAtIndex:i]];
                
            }
            
        }
        
        centerCard --;
        
        
        for (int j=0; j<6-centerCard; j++) {
            
            [CardPanel exchangeSubviewAtIndex:centerCard+j+1 withSubviewAtIndex:centerCard+j];
            
        }
    }
    
    else //elastic reaction
    {
        
        [self ElasticReboundToRight];
        
    }
    
    
    
}

-(void)PushCardPanelLeft
{
    
    if (centerCard<6) {
        
        for (int i =6; i>=0; i--) {
            
            if (i>centerCard) {
                [self ScaleUpToLeft:[Cards objectAtIndex:i]];
            }
            else 
            {
                [self ScaleDownToLeft:[Cards objectAtIndex:i]];
                
            }
            
        }
        
        
        centerCard ++;
        
        
        for (int j=6-centerCard; j>=0; j--) {
            
            [CardPanel exchangeSubviewAtIndex:centerCard+j-1 withSubviewAtIndex:centerCard+j];
            
        }
        
        
    }
    
    else //elatic reaction
        
    {
        [self ElasticReboundToLeft];
    }
}

-(void)PushCardPanelDown
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CardPanel.center = CGPointMake(384, 984);
        
    }];
    
    Paneldown = YES;
    
    
    
}

-(void) PullCardPanelUp
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CardPanel.center = CGPointMake(384, 734);
        SelectedCard.center = CGPointMake(384, 734);
        
        
        
    } completion:^(BOOL finished){
        
        ((UIImageView*)[Cards objectAtIndex:centerCard]).alpha = 1;
        SelectedCard.alpha = 0;
        
        Paneldown = NO;
        
    }];
    
    
}


- (IBAction)RightSwipeAction:(id)sender {
    
    if (!Paneldown) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self PushCardPanelRight];
        }];
    }
    
}

- (IBAction)LeftSwipeAction:(id)sender {
    
    if (!Paneldown) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self PushCardPanelLeft];
        }];
    }
    
}

- (IBAction)TapAction:(id)sender {
    
    if (Paneldown) {
        
        [self PullCardPanelUp];
        
    }
    
    
    
}

- (IBAction)UpSwipeSelectAction:(id)sender {
    
    if (!Paneldown) {
        
        int x = [UpSwipeSelectGest locationInView:CardPanel].x;
        
        if(x>224 && x<544) //action on center card
        {
            
            SelectedCard.image = ((UIImageView*)[Cards objectAtIndex:centerCard]).image;
            
            ((UIImageView*)[Cards objectAtIndex:centerCard]).alpha =0;
            
            SelectedCard.alpha =1;
            
            [UIView animateWithDuration:0.5 animations:^{
                
                
                SelectedCard.center = CGPointMake(384, 300);
                
                
            }];
            
            [self PushCardPanelDown];
            
        }
    }
    
}

- (IBAction)BackgroundTapAction:(id)sender {
    
    if (!Paneldown) {
        [self PushCardPanelDown];
    }
}

@end
