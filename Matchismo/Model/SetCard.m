//
//  SetCard.m
//  Matchismo
//
//  Created by Barak Weiss on 23/05/2016.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (NSString *)contents {
   return @"";
}

- (int)match:(NSArray<Card *> *)otherCards {
  if (otherCards.count != 2) {
    return 0;
  }
  
  SetCard *secondCard = (SetCard *)otherCards[0];
  SetCard *thirdCard = (SetCard *)otherCards[1];
  
  if (!([self setEquals:self.number
                 second:secondCard.number
                  third:thirdCard.number])) {
    return 0;
  }
  
  if (!([self setEquals:self.symbol
                 second:secondCard.symbol
                  third:thirdCard.symbol])) {
    return 0;
  }
  
  if (!([self setEquals:self.shading
                 second:secondCard.shading
                  third:thirdCard.shading])) {
    return 0;
  }
  
  if (!([self setEquals:self.color
                 second:secondCard.color
                  third:thirdCard.color])) {
    return 0;
  }
  
  return 1;
}

- (BOOL) setEquals:(NSNumber *)first second:(NSNumber *)second third:(NSNumber *)third {
  int equalCount = 0;
  
  if (first == second) {
    equalCount++;
  }

  if (second == third) {
    equalCount++;
  }

  if (third == first) {
    equalCount++;
  }

  return (equalCount == 0 || equalCount == 3);
}

+ (NSArray<NSNumber *> *)defaultSetValues {
  return @[@0, @1, @2];
}

+ (NSArray<NSNumber *> *)validNumbers {
  return [self defaultSetValues];
}

+ (NSArray<NSNumber *> *)validSymbols {
  return [self defaultSetValues];
}

+ (NSArray<NSNumber *> *)validShadings {
  return [self defaultSetValues];
}

+ (NSArray<NSNumber *> *)validColors {
  return [self defaultSetValues];
}

@end
