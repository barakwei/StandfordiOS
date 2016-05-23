//
//  Card.m
//  Matchismo
//
//  Created by Barak Weiss on 5/17/16.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

-(int)match:(NSArray *)otherCards
{
  int score = 0;
  
  for (Card *card in otherCards) {
    if ([card.contents isEqualToString:self.contents]) {
      score = 1;
    }
  }
  
  return score;
}

@end
