//
//  PlayingCardGameViewController.h
//  Matchismo
//
//  Created by Barak Weiss on 22/05/2016.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "CardGameViewController.h"

@interface PlayingCardGameViewController : CardGameViewController

- (Deck *) createDeck;
- (NSAttributedString *)getCardText:(Card *)card;

@end
