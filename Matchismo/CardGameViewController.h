//
//  ViewController.h
//  Matchismo
//
//  Created by Barak Weiss on 5/17/16.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model/Deck.h"
#import "Model/CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) CardMatchingGame *game;

- (Deck*) createDeck;                               // Abstract
- (NSUInteger) matchNumber;                         // Abstract
- (NSAttributedString *)titleForCard:(Card *)card;  // Abstract
- (UIImage *)backgroundImageForCard:(Card *)card;   // Abstract
- (BOOL) showTitleForCard:(Card *)card;             // Abstract

@end
