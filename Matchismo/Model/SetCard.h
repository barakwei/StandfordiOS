//
//  SetCard.h
//  Matchismo
//
//  Created by Barak Weiss on 23/05/2016.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;

+ (NSArray *)validNumbers; // of NSString
+ (NSArray *)validSymbols; // of NSString
+ (NSArray *)validShadings; // of NSString
+ (NSArray *)validColors; // of NSString

@end
