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
    for (NSString *shading in [SetCard validShadings]) {
      for (NSString *color in [SetCard validColors]) {
        for (NSString *number in [SetCard validNumbers]) {
          for (NSString *symbol in [SetCard validSymbols]) {
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
