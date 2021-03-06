//
//  PlayingCard.m
//  Matchismo
//
//  Created by Barak Weiss on 5/17/16.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents {
    return  [self.rank stringByAppendingString:self.suit];
}

@synthesize suit = _suit;
+ (NSArray<NSString *> *)validSuits {
    return @[@"♥︎", @"♦︎", @"♠︎", @"♣︎"];
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

- (int)matchRec:(NSArray<Card *> *)otherCards {
  if (otherCards.count == 0)
  {
    return 0;
  }

  int score = 0;
  
  for (PlayingCard *otherCard in otherCards)
  {
    if ([self.suit isEqualToString:otherCard.suit]) {
      score = 2;
    } else if (self.rank == otherCard.rank) {
      score = 6;
    }
  }
  
  NSMutableArray* lessCards = [otherCards mutableCopy];
  PlayingCard *card = [lessCards lastObject];
  [lessCards removeLastObject];
  
  return score + [card matchRec:lessCards];
}

- (int)match:(NSArray<Card *> *)otherCards {
  int totalScore = [self matchRec:otherCards];
  
  return totalScore / otherCards.count;
}

+ (NSArray<NSString *> *)validRanks
{
    return @[@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

@end
