//
//  ViewController.h
//  Matchismo
//
//  Created by Barak Weiss on 5/17/16.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model/Deck.h"

@interface CardGameViewController : UIViewController

- (Deck*) createDeck;
- (NSUInteger) matchNumber;

@end
