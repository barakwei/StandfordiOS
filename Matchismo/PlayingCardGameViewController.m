//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Barak Weiss on 22/05/2016.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *) createDeck {
  return [[PlayingCardDeck alloc] init];
}

- (NSUInteger) matchNumber {
  return 2;
}

- (NSAttributedString *)titleForCard:(Card *)card {
  return card.isChosen ?
    [[NSAttributedString alloc] initWithString:((PlayingCard *)card).contents] :
    [[NSAttributedString alloc] initWithString:@""];
}

- (UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
