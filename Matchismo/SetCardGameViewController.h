//
//  SetCardGameViewController.h
//  Matchismo
//
//  Created by Barak Weiss on 23/05/2016.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "CardGameViewController.h"
#import "SetCardView.h"

@interface SetCardGameViewController : CardGameViewController

- (Deck*) createDeck;
- (NSUInteger) matchNumber;
- (UIImage *)backgroundImageForCard:(Card *)card;
- (NSUInteger) defaultNumberOfCardsOnBoard;
- (void) updateCardView:(CardView *)view card:(Card *)card;
- (CardView *)createCardViewForCard:(Card *)card;

@end
