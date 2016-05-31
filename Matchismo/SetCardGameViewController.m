//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Barak Weiss on 23/05/2016.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardView.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

#pragma mark CardGameVewController interface

- (Deck *) createDeck {
  return [[SetCardDeck alloc] init];
}

- (NSUInteger) matchNumber {
  return 3;
}

- (NSUInteger) defaultNumberOfCardsOnBoard {
  return 12;
}

- (CardView *)createCardViewForCard:(Card *)card {
  SetCardView *newView = [[SetCardView alloc] init];
  newView.card = card;
  [self updateCardView:newView card:card];
  return newView;
}

- (UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed:@"cardfront"];
}

- (NSUInteger)numberOfCardsOnMoreCardsRequest { // Abstract
  return 3;
}

- (void) updateCardView:(CardView *)view card:(Card *)card {
  if ([card isKindOfClass:[SetCard class]] && [view isKindOfClass:[SetCardView class]]) {
    SetCard *setCard = (SetCard *)card;
    SetCardView *setCardView = (SetCardView *)view;
    setCardView.symbol = setCard.symbol.integerValue;
    setCardView.color = setCard.color.integerValue;
    setCardView.shading = setCard.shading.integerValue;
    setCardView.number = setCard.number.integerValue;
    setCardView.highlighted = setCard.isChosen;
  }
  
  if (card.isMatched) {
    [self removeCardViewFromBoard:view];
    [self dealCards:1];
  }
}

#pragma mark Lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.game = self.game;
}

@end
