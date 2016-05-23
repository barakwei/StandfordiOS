//
//  SetCardGameViewController.h
//  Matchismo
//
//  Created by Barak Weiss on 23/05/2016.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "CardGameViewController.h"

@interface SetCardGameViewController : CardGameViewController

- (Deck *) createDeck;
- (NSAttributedString *)getCardText:(Card *)card;

@end
