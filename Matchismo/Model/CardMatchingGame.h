//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Barak Weiss on 5/17/16.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (instancetype)initWithCardCountAndMatchNumber:(NSUInteger)count
                                numberOfMatches:(NSUInteger)numMatches
                                      usingDeck:(Deck *)deck NS_DESIGNATED_INITIALIZER;

//- (void)chooseCardAtIndex:(NSUInteger)index;
- (void)chooseCard:(Card *)card;

- (Card *)cardAtIndex:(NSUInteger)index;

- (NSAttributedString *)getCardText:(Card *)card; // Abstract

- (Card *)dealCardFromDeck;

- (NSUInteger)numCardsLeftInDeck;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSString *lastMove;
@property (nonatomic, readonly) NSArray<Card *> *lastMoveCards;
@end
