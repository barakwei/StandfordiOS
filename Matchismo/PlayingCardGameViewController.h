//
//  PlayingCardGameViewController.h
//  Matchismo
//
//  Created by Barak Weiss on 22/05/2016.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardView.h"

@interface PlayingCardGameViewController : CardGameViewController

- (Deck*) createDeck;
- (NSUInteger) matchNumber;
- (NSAttributedString *)titleForCard:(Card *)card;
- (UIImage *)backgroundImageForCard:(Card *)card;
- (NSUInteger) defaultNumberOfCardsOnBoard;
- (void) updateCardView:(CardView *)view card:(Card *)card;
- (CardView *)createCardViewForCard:(Card *)card;

@end
