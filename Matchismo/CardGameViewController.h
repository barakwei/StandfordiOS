//
//  ViewController.h
//  Matchismo
//
//  Created by Barak Weiss on 5/17/16.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model/Deck.h"
#import "Model/CardMatchingGame.h"
#import "CardView.h"

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) CardMatchingGame *game;

- (Deck*) createDeck;                                       // Abstract
- (NSUInteger)matchNumber;                                  // Abstract
- (NSAttributedString *)titleForCard:(Card *)card;          // Abstract
- (UIImage *)backgroundImageForCard:(Card *)card;           // Abstract
- (NSUInteger)defaultNumberOfCardsOnBoard;                  // Abstract
- (void)updateCardView:(CardView *)view card:(Card *)card;  // Abstract
- (CardView *)createCardViewForCard:(Card *)card;           // Abstract
- (NSUInteger)numberOfCardsOnMoreCardsRequest;              // Abstract

- (void)dealCards:(NSUInteger)numberOfCards;       // Protected
- (void) addCardViewToBoard:(CardView *)view;      // Protecteג
- (void) removeCardViewFromBoard:(CardView *)view; // Protected

@end
