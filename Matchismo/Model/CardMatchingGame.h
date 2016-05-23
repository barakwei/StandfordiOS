//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Barak Weiss on 5/17/16.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (instancetype)initWithCardCountAndMatchNumber:(NSUInteger)count
                                    matchNumber:(NSUInteger)matchNum
                                      usingDeck:(Deck *)deck NS_DESIGNATED_INITIALIZER;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSString *lastMove;

@end
