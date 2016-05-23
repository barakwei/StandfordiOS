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
  if (otherCards.count != 3) {
    return 0;
  }
  
  if (!([self setEqualsString:self.number
                       second:((SetCard *)otherCards[0]).number
                        third:((SetCard *)otherCards[1]).number])) {
    return 0;
  }
  
  return 1;
}

- (BOOL) callSelector:(SetCard *) card property:(SEL) property
{
  
  //[card performSelector:property];
  
  IMP imp = [card methodForSelector:property];
  void (*func)(id, SEL) = (void *)imp;
  func(card, property);

  return YES;
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
  return @[@"one", @"two", @"three"];
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
