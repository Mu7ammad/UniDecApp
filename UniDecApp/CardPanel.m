//
//  CardPanel.m
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import "CardPanel.h"

@implementation CardPanel
@synthesize PanelDown;
@synthesize PanelView;

-(id)init:(NSArray *)cardNames from:(NSDictionary *)CardLibrary
{

  self = [super init];
    
    NSMutableArray* cards = [[NSMutableArray alloc]init];
        
    for (NSString* name in cardNames) {
        
        
        [cards addObject:[[Card alloc] init:name from:CardLibrary]]; 
    }
    
    Cards = cards;
    
    SelectedCard = [[Card alloc]init];
    
    return self;


}

-(void)takeCardViews:(NSArray *)cardViews and:(UIImageView *)selectedCardView

{

    
    for (int i =0; i<7; i++ ) {
        
        ((Card*)[Cards objectAtIndex:i]).view = [cardViews objectAtIndex:i];
        
    }
    
    SelectedCard.view = selectedCardView;
    SelectedCard.view.alpha =0;
    
    //spread Cards
    for (int i = 5; i>=0; i--) {
        
        for (int j=0; j<6-i; j++) {
            
            [((Card*) [Cards objectAtIndex:i]) ScaleDownToLeft];
            
        }
    }
    
    centerCard = 6;
    
    
    for (int i =0; i<3; i++) {
        
        [self PushRight];
        
    }


}


-(Card *)SelectCard
{
    
    if (!PanelDown) {
        
        //copy
        [SelectedCard copyCard:[Cards objectAtIndex:centerCard]];
        
        
        
        //animations
        ((Card*)[Cards objectAtIndex:centerCard]).view.alpha =0;
        
        SelectedCard.view.alpha =1;
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            
            CGPoint center = CGPointMake(384,300);                
            
            SelectedCard.view.center = center;
            
            
        }];
        
        [self PushDown];
        
    }
    
    return SelectedCard;
}

-(Card *)SelectCardNo:(int)num{
    
    [SelectedCard copyCard:[Cards objectAtIndex:num]];
    
    return SelectedCard;
}


-(NSArray *)getCardNames{
    
    NSMutableArray* cardNames = [[NSMutableArray alloc]init];
    
    for (Card* card in Cards) {
        
        [cardNames addObject:card.name];
    }
    
    return [[NSArray alloc]initWithArray:cardNames];
}

//UI Animations

-(void)PushRight
{
    
    if (!PanelDown && centerCard>0) {
         [UIView animateWithDuration:0.3 animations:^{
         
             
                 for (int i =6; i>=0; i--) {
                     
                     if (i>=centerCard) {
                         [(Card*)[Cards objectAtIndex:i] ScaleDownToRight];
                     }
                     else 
                     {
                         [(Card*)[Cards objectAtIndex:i] ScaleUpToRight];
                         
                     }
                     
                 }
                 
                 centerCard --;
                 
                 
                 for (int j=0; j<6-centerCard; j++) {
                     
                     [PanelView exchangeSubviewAtIndex:centerCard+j+1 withSubviewAtIndex:centerCard+j];
                     
                 }
         
         }];
    }
    
    else
    {
        [self ElasticReboundToRight];
    
    }
}

-(void)PushLeft
{
    
    if (!PanelDown && centerCard<6) {
        [UIView animateWithDuration:0.3 animations:^{
        
            
            for (int i =6; i>=0; i--) {
                
                if (i>centerCard) {
                    [(Card*)[Cards objectAtIndex:i] ScaleUpToLeft];
                }
                else 
                {
                    [(Card*)[Cards objectAtIndex:i] ScaleDownToLeft];
                    
                }
                
            }
            
            
            centerCard ++;
            
            
            for (int j=6-centerCard; j>=0; j--) {
                
                [PanelView exchangeSubviewAtIndex:centerCard+j-1 withSubviewAtIndex:centerCard+j];
                
            }
            
        }];
    }
    else 
    {
    
        [self ElasticReboundToLeft];
    }

}


-(void)PushDown
{
     [UIView animateWithDuration:0.5 animations:^{
         
         
    PanelView.center = CGPointMake(384, 984);
         
     }];
         
      PanelDown = YES;


}

-(void)PullUp
{
    [UIView animateWithDuration:0.5 animations:^{
    
    PanelView.center = CGPointMake(384, 734);
        
    SelectedCard.view.center = CGPointMake(384, 734);
        
       
        
    } completion:^(BOOL finished){
    
      ((Card*)[Cards objectAtIndex:centerCard]).view.alpha =1;
        SelectedCard.view.alpha =0;
    }];
     
    PanelDown = NO;

}

-(void)ElasticReboundToLeft
{

    
    [UIView animateWithDuration:0.3 animations:^{
        
        for (int i =6; i>=0; i--) {
             [(Card*)[Cards objectAtIndex:i] ScaleDownToLeft];
        }
        
    }completion:^(BOOL finished){
        
        [UIView animateWithDuration:0.3 animations:^{
            for (int i =6; i>=0; i--) {
                 [(Card*)[Cards objectAtIndex:i] ScaleUpToRight];
            }
        }];
        
    }];
    
    

}

-(void)ElasticReboundToRight
{

    
    [UIView animateWithDuration:0.3 animations:^{
        
        for (int i =6; i>=0; i--) {
            [(Card*)[Cards objectAtIndex:i] ScaleDownToRight];

        }
        
        
    } completion:^(BOOL finished){
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            for (int i =6; i>=0; i--){
                [(Card*)[Cards objectAtIndex:i] ScaleUpToLeft];

            } 
            
        }];
        
    }];


}

@end
