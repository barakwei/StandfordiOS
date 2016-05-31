//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Barak Weiss on 23/05/2016.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
  self = [super init];
  
  if (self) {
    for (NSNumber *shading in [SetCard validShadings]) {
      for (NSNumber *color in [SetCard validColors]) {
        for (NSNumber *number in [SetCard validNumbers]) {
          for (NSNumber *symbol in [SetCard validSymbols]) {
            SetCard* card = [[SetCard alloc] init];
            card.shading = shading;
            card.color = color;
            card.number = number;
            card.symbol = symbol;
            [self addCard:card];
          }
        }
      }
    }
  }
  
  return self;
}

@end
