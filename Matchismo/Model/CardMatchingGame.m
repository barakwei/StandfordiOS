//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Barak Weiss on 5/17/16.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of Card
@property (nonatomic) NSUInteger matchNum;
@property (nonatomic, readwrite) NSString *lastMove;
@end

@implementation CardMatchingGame

- (NSAttributedString *)getCardText:(Card *)card {
  return nil;
}

- (NSMutableArray *)cards
{
  if (!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck {
  return [self initWithCardCountAndMatchNumber:count matchNumber:2 usingDeck:deck];
}

- (instancetype)initWithCardCountAndMatchNumber:(NSUInteger)count
                                    matchNumber:(NSUInteger)matchNum
                                      usingDeck:(Deck *)deck {
  
  if (self = [super init]) {
    
    if (count < 2) return nil;
    
    for (int i = 0; i < count; i++) {
      Card* card = [deck drawRandomCard];
      if (!card) {
        return nil;
      }
      
      [self.cards addObject:card];
    }
  }
  self.matchNum = matchNum;
  
  return self;
  
}


- (Card *)cardAtIndex:(NSUInteger)index {
  return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (NSString *)chosenCardsString:(Card *) extraCard {
  NSMutableString *chosenCardStr = [[NSMutableString alloc] init];
  
  if (extraCard) {
    [chosenCardStr appendFormat:@"%@ ", extraCard.contents];
  }
  
  for (Card *otherCard in self.cards) {
    if (otherCard.isChosen && !otherCard.isMatched) {
      [chosenCardStr appendFormat:@"%@ ", otherCard.contents];
    }
  }
 
  return chosenCardStr;
}

- (NSString *)chosenCardsString {
  return [self chosenCardsString:nil];
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
  Card *card = [self cardAtIndex:index];
  
  if (!card.isMatched) {
    if (card.isChosen) {
      card.chosen = NO;
      self.lastMove = [self chosenCardsString];
    } else {
      NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
      
      for (Card *otherCard in self.cards) {
        if (otherCard.isChosen && !otherCard.isMatched) {
          [chosenCards addObject:otherCard];
        }
      }
      
      if (chosenCards.count == self.matchNum - 1)
      {
        int matchScore = [card match:chosenCards];
        if (matchScore) {
          self.score += matchScore * MATCH_BONUS;
          card.chosen = YES;
          self.lastMove  = [NSString stringWithFormat:@"%@ are a match! You got %d points!", [self chosenCardsString], matchScore * MATCH_BONUS];
          card.matched = YES;
          for (Card *chosenCard in chosenCards) { chosenCard.matched = YES; }
        } else {
          self.score -= MISMATCH_PENALTY;
          self.lastMove  = [NSString stringWithFormat:@"%@ do not match! %d points penalty!", [self chosenCardsString:card], MISMATCH_PENALTY];
          for (Card *card in chosenCards) { card.chosen = NO; }
        }
        return;
      }
      
      // We've not reached matchNumber, just show the chosen card this far
      self.score -= COST_TO_CHOOSE;
      card.chosen = YES;
      self.lastMove = [self chosenCardsString];
    }
  }
}


//- (instancetype) init {
//  return nil;
//}

@end
