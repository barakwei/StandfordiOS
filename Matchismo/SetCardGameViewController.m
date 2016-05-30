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

- (NSAttributedString *)titleForCard:(Card *)card {
  SetCard *setCard = (SetCard *)card;
  NSString *base = [setCard.number stringByAppendingString:setCard.symbol];
  
  UIColor *color = [self setCardColorToUiColor:setCard];
  UIColor *colorWithAlpha = [color colorWithAlphaComponent:[self setCardShadingToAlpha:setCard]];
  
  NSDictionary<NSString *, id> *attribs = @{
                                            NSForegroundColorAttributeName : colorWithAlpha,
                                            NSStrokeWidthAttributeName : @-8,
                                            NSStrokeColorAttributeName : color,
                                            };
  
  NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:base attributes:attribs];
  
  return text;
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

- (UIColor *)setCardColorToUiColor:(SetCard *)card {
  
  if ([card.color isEqualToString:@"red"]) {
    return [UIColor redColor];
  }
  
  if ([card.color isEqualToString:@"green"]) {
    return [UIColor greenColor];
  }
  
  if ([card.color isEqualToString:@"purple"]) {
    return [UIColor purpleColor];
  }
  
  return [UIColor blackColor];
}

- (CGFloat) setCardShadingToAlpha:(SetCard *)card {
  
  if ([card.shading isEqualToString:@"solid"]) {
    return 1.0;
  }
  
  if ([card.shading isEqualToString:@"striped"]) {
    return 0.5;
  }
  
  if ([card.shading isEqualToString:@"open"]) {
    return 0.0;
  }
  
  return 0;
}

- (NSUInteger)numberOfCardsOnMoreCardsRequest { // Abstract
  return 3;
}

- (void) updateCardView:(CardView *)view card:(Card *)card {
  if ([card isKindOfClass:[SetCard class]] && [view isKindOfClass:[SetCardView class]]) {
    SetCard *setCard = (SetCard *)card;
    SetCardView *setCardView = (SetCardView *)view;
    setCardView.symbol = setCard.symbol;
    setCardView.color = setCard.color;
    setCardView.shading = setCard.shading;
    setCardView.number = setCard.number;
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
