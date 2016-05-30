//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Barak Weiss on 22/05/2016.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "PlayingCardGameViewController.h"
// :: Other ::
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"

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
  return [[NSAttributedString alloc] initWithString:((PlayingCard *)card).contents];
}

- (UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (NSUInteger) defaultNumberOfCardsOnBoard {
  return 20;
}

- (void) updateCardView:(CardView *)view card:(Card *)card {
  if ([card isKindOfClass:[PlayingCard class]] && [view isKindOfClass:[PlayingCardView class]]) {
    PlayingCard *playingCard = (PlayingCard *)card;
    PlayingCardView *playingCardView = (PlayingCardView *)view;
    playingCardView.rank = playingCard.rank;
    playingCardView.suit = playingCard.suit;
    
    if (playingCardView.faceUp != playingCard.isChosen) {
      [UIView transitionWithView:view
                        duration:0.2
                         options:UIViewAnimationOptionTransitionFlipFromLeft
                      animations:^{
                        playingCardView.faceUp = playingCard.isChosen;
                      }
                      completion:nil];
    }
    
    // playingCardView.faceUp = playingCard.isChosen
    ;
  }
}

- (CardView *)createCardViewForCard:(Card *)card {
  PlayingCardView *newView = [[PlayingCardView alloc] init];
  newView.card = card;
  [self updateCardView:newView card:card];
  return newView;
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
