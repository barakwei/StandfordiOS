//
//  ViewController.m
//  Matchismo
//
//  Created by Barak Weiss on 5/17/16.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "CardGameViewController.h"
#import "Model/Deck.h"
#import "Model/CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) NSUInteger matchNumber;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLabel;
@end

@implementation CardGameViewController


- (CardMatchingGame *)game {
  if (!_game) _game = [[CardMatchingGame alloc] initWithCardCountAndMatchNumber:[self.cardButtons count]
                                                                    matchNumber:self.matchNumber
                                                                      usingDeck:[self createDeck]];
  return _game;
}

- (NSUInteger) matchNumber { // Abstract
  return 0;
}

- (NSAttributedString *)getCardText:(Card *)card { // Abstract
  return nil;
}

- (Deck*) createDeck { // Abstract
  return nil;
}

- (IBAction)touchDealButton:(UIButton *)sender {
  self.game = nil;
  [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {
  NSInteger cardIndex = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:cardIndex];
  [self updateUI];
}

- (void) updateUI {
  for (UIButton* button in _cardButtons) {
    NSInteger cardIndex = [self.cardButtons indexOfObject:button];
    Card* card = [self.game cardAtIndex:cardIndex];
    [button setAttributedTitle:[self titleForCard:card]
            forState:UIControlStateNormal];
    [button setBackgroundImage:[self backgroundImageForCard:card]
                      forState:UIControlStateNormal];
    button.enabled = !card.isMatched;
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
  self.lastMoveLabel.text = self.game.lastMove;
}

- (NSAttributedString *)titleForCard:(Card *)card {
  return card.isChosen ? [self getCardText:card] : [[NSAttributedString alloc] initWithString:@""];
}

- (UIImage *)backgroundImageForCard:(Card *)card {
  return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (Deck*)deck {
  if (!_deck) _deck = [self createDeck];
  return _deck;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
