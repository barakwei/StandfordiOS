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
@property (nonatomic, strong) NSMutableArray<Card *> *cards; //of Card
@property (nonatomic) NSUInteger numberOfMatches;
@property (nonatomic, readwrite) NSString *lastMove;
@property (nonatomic, readwrite) NSArray<Card *> *lastMoveCards; // of Card
@property (nonatomic, readwrite) Deck *deck;
@end

@implementation CardMatchingGame

- (NSAttributedString *)getCardText:(Card *)card {
  return nil;
}

- (NSString *)lastMove {
  if (!_lastMove) _lastMove = @"";
  return  _lastMove;
}

- (NSMutableArray *)cards {
  if (!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (Card *)dealCardFromDeck {
  Card* card = [self.deck drawRandomCard];
  if (!card) {
    return nil;
  }
  
  [self.cards addObject:card];
  
  return card;
}

- (NSUInteger)numCardsLeftInDeck {
  return [self.deck numCardsLeftInDeck];
}

- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck {
  return [self initWithCardCountAndMatchNumber:count numberOfMatches:2 usingDeck:deck];
}

- (instancetype)initWithCardCountAndMatchNumber:(NSUInteger)count
                                numberOfMatches:(NSUInteger)numMatches
                                      usingDeck:(Deck *)deck {
  
  if (self = [super init]) {
    
    if (count < 2) return nil;
    
    self.deck = deck;
    
  }
  self.numberOfMatches = numMatches;
  
  return self;
  
}


- (Card *)cardAtIndex:(NSUInteger)index {
  return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (NSArray<Card *> *)chosenCards:(Card *) extraCard {
  NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
  
  if (extraCard) {
    [chosenCards addObject:extraCard];
  }
  
  for (Card *otherCard in self.cards) {
    if (otherCard.isChosen && !otherCard.isMatched) {
      [chosenCards addObject:otherCard];
    }
  }
 
  return chosenCards;
}

- (NSArray<Card *> *)chosenCards {
  return [self chosenCards:nil];
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
  Card *card = [self cardAtIndex:index];
  [self chooseCard:card];
}

- (void)chooseCard:(Card *)card {
  if (!card.isMatched) {
    if (card.isChosen) {
      card.chosen = NO;
      self.lastMove = [[NSString alloc] init];
      self.lastMoveCards = [self chosenCards];
    } else {
    
      NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
      
      for (Card *otherCard in self.cards) {
        if (otherCard.isChosen && !otherCard.isMatched) {
          [chosenCards addObject:otherCard];
        }
      }
      
      if (chosenCards.count == self.numberOfMatches - 1)
      {
        int matchScore = [card match:chosenCards];
        if (matchScore) {
          self.score += matchScore * MATCH_BONUS;
          self.lastMove  = [NSString stringWithFormat:@"are a match! You got %d points!", matchScore * MATCH_BONUS];
          card.chosen = YES;
          card.matched = YES;
          for (Card *chosenCard in chosenCards) { chosenCard.matched = YES; }
        } else {
          self.score -= MISMATCH_PENALTY;
          self.lastMove  = [NSString stringWithFormat:@"are not match! %d points penalty!", MISMATCH_PENALTY];
          for (Card *card in chosenCards) { card.chosen = NO; }
        }
      } else {
        // We've not reached matchNumber, just show the chosen card this far
        self.score -= COST_TO_CHOOSE;
        card.chosen = YES;
        self.lastMove = [[NSString alloc] init];
      }
      
      [chosenCards addObject:card];
      self.lastMoveCards = chosenCards;
    }
  }
}


//- (instancetype) init {
//  return nil;
//}

@end
