//
//  SetCard.h
//  Matchismo
//
//  Created by Barak Weiss on 23/05/2016.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSNumber *number;
@property (nonatomic) NSNumber *symbol;
@property (nonatomic) NSNumber *shading;
@property (nonatomic) NSNumber *color;

+ (NSArray<NSNumber *> *)validNumbers;
+ (NSArray<NSNumber *> *)validSymbols;
+ (NSArray<NSNumber *> *)validShadings;
+ (NSArray<NSNumber *> *)validColors;

@end
