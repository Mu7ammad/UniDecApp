//
//  CardPanel.h
//  DecApp
//
//  Created by Muhammad Hilal on 12/4/11.
//  Copyright (c) 2011 Pirates. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


//connect to UI (Cards swiping and selecting)
@interface CardPanel : NSObject

{

    NSArray* Cards;
    
    Card* SelectedCard;
    
    int centerCard;
    
}

@property bool PanelDown;
@property (weak, nonatomic) UIView* PanelView;

-(id)init:(NSArray*)cardNames from:(NSDictionary *)CardLibrary;
//modify later
-(void) takeCardViews: (NSArray*) cardViews and: (UIImageView*) selectedCardView;

-(void) ElasticReboundToRight;
-(void) ElasticReboundToLeft;
-(void) PushLeft;
-(void) PushRight;
-(void) PushDown;
-(void) PullUp;
-(void) PushRight;

-(Card*) SelectCard;


@end
