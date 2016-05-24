//
//  SetCardGameViewController.h
//  Matchismo
//
//  Created by Barak Weiss on 23/05/2016.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "CardGameViewController.h"

@interface SetCardGameViewController : CardGameViewController

- (Deck*) createDeck;
- (NSUInteger) matchNumber;
- (NSAttributedString *)titleForCard:(Card *)card;
- (UIImage *)backgroundImageForCard:(Card *)card;

@end
