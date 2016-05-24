//
//  PlayingCardGameViewController.h
//  Matchismo
//
//  Created by Barak Weiss on 22/05/2016.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "CardGameViewController.h"

@interface PlayingCardGameViewController : CardGameViewController

- (Deck*) createDeck;
- (NSUInteger) matchNumber;
- (NSAttributedString *)titleForCard:(Card *)card;
- (UIImage *)backgroundImageForCard:(Card *)card;

@end
