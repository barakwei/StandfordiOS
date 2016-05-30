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

- (int)match:(NSArray *)otherCards {
  if (otherCards.count != 2) {
    return 0;
  }
  
  if (!([self setEqualsString:self.number
                       second:((SetCard *)otherCards[0]).number
                        third:((SetCard *)otherCards[1]).number])) {
    return 0;
  }
  
  if (!([self setEqualsString:self.symbol
                       second:((SetCard *)otherCards[0]).symbol
                        third:((SetCard *)otherCards[1]).symbol])) {
    return 0;
  }
  
  if (!([self setEqualsString:self.shading
                       second:((SetCard *)otherCards[0]).shading
                        third:((SetCard *)otherCards[1]).shading])) {
    return 0;
  }
  
  if (!([self setEqualsString:self.color
                       second:((SetCard *)otherCards[0]).color
                        third:((SetCard *)otherCards[1]).color])) {
    return 0;
  }
  
  return 1;
}

- (BOOL) setEqualsString:(NSString *)first second:(NSString *)second third:(NSString *)third {
  int equalCount = 0;
  
  if ([first isEqualToString:second]) {
    equalCount++;
  }

  if ([second isEqualToString:third]) {
    equalCount++;
  }

  if ([third isEqualToString:first]) {
    equalCount++;
  }

  return (equalCount == 0 || equalCount == 3);
}

+ (NSArray *)validNumbers {
  return @[@"1", @"2", @"3"];
}

+ (NSArray *)validSymbols {
  return @[@"diamond", @"squiggle", @"oval"];
}

+ (NSArray *)validShadings {
  return @[@"solid", @"striped", @"open"];
}

+ (NSArray *)validColors {
  return @[@"red", @"green", @"purple"];
}

@end
