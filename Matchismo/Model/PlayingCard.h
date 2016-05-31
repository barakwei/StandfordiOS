//
//  PlayingCard.h
//  Matchismo
//
//  Created by Barak Weiss on 5/17/16.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (strong, nonatomic) NSString *rank;

+ (NSArray<NSString *> *)validSuits;
+ (NSArray<NSString *> *)validRanks;

@end
