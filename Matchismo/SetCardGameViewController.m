//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Barak Weiss on 23/05/2016.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

// CardGameVewController interface
- (Deck *) createDeck {
  return [[SetCardDeck alloc] init];
}

- (NSUInteger) matchNumber {
  return 3;
}

- (NSAttributedString *)getCardText:(Card *)card {
  // Samatuha
  
  SetCard *setCard = (SetCard *)card;
  NSString *base = [setCard.number stringByAppendingString:setCard.symbol];
  
  UIColor *color = [self setCardColorToUiColor:setCard];
  UIColor *colorWithAlpha = [color colorWithAlphaComponent:[self setCardShadingToAlpha:setCard]];
  
  NSDictionary<NSString *, id> *attribs = @{
                                            NSForegroundColorAttributeName : colorWithAlpha,
                                            NSStrokeWidthAttributeName : @-3,
                                            NSStrokeColorAttributeName : color,
                                            };
  
  NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:base attributes:attribs];
  
  return text;
}

- (UIColor *) setCardColorToUiColor:(SetCard *)card {

  if ([card.shading isEqualToString:@"red"]) {
    return [UIColor redColor];
  }
  
  if ([card.shading isEqualToString:@"green"]) {
    return [UIColor greenColor];
  }
  
  if ([card.shading isEqualToString:@"purple"]) {
    return [UIColor purpleColor];
  }
  
  return [UIColor blackColor];
}

- (CGFloat) setCardShadingToAlpha:(SetCard *)card {

  if ([card.shading isEqualToString:@"solid"]) {
    return 1.0;
  }
  
  if ([card.shading isEqualToString:@"striped"]) {
    return 0.8;
  }
  
  if ([card.shading isEqualToString:@"open"]) {
    return 0.5;
  }
  
  return 0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
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
