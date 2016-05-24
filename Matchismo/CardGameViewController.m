//
//  ViewController.m
//  Matchismo
//
//  Created by Barak Weiss on 5/17/16.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
//@property (strong, nonatomic) Deck *deck;
@property (nonatomic) NSUInteger matchNumber;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLabel;
@property (strong, nonatomic) NSMutableAttributedString *history;
@end

@implementation CardGameViewController

- (NSUInteger) matchNumber { // Abstract
  return 0;
}

- (NSAttributedString *)titleForCard:(Card *)card { // Abstract
  return nil;
}

- (Deck*) createDeck { // Abstract
  return nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card { // Abstract
  return nil;
}

- (BOOL) showTitleForCard:(Card *)card { // Abstract
  return NO;
}

- (NSAttributedString *)history {
  if (!_history) _history = [[NSMutableAttributedString alloc] initWithString:@""];
  return _history;
}

- (void)appendHistory:(NSAttributedString *)line {
  [self.history appendAttributedString:line];
  [self.history appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
}

- (CardMatchingGame *)game {
  if (!_game) _game = [[CardMatchingGame alloc] initWithCardCountAndMatchNumber:[self.cardButtons count]
                                                                    matchNumber:self.matchNumber
                                                                      usingDeck:[self createDeck]];
  return _game;
}

- (IBAction)touchDealButton:(UIButton *)sender {
  self.game = nil;
  self.history = nil;
  [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {
  NSInteger cardIndex = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:cardIndex];
  [self updateUI];
  [self appendHistory:[self generateLastMoveString]];
}

- (NSAttributedString *) generateLastMoveString {
  NSMutableAttributedString * moveDetails = [[NSMutableAttributedString alloc] init];
  for (Card *lastMoveCard in self.game.lastMoveCards) {
    [moveDetails appendAttributedString:[self titleForCard:lastMoveCard]];
  }
  
  [moveDetails appendAttributedString:[[NSAttributedString alloc] initWithString:self.game.lastMove]];
  return moveDetails;
}

- (void) updateUI {
  for (UIButton* button in _cardButtons) {
    NSInteger cardIndex = [self.cardButtons indexOfObject:button];
    Card* card = [self.game cardAtIndex:cardIndex];
    
    if ([self showTitleForCard:card]) {
      [button setAttributedTitle:[self titleForCard:card]
                        forState:UIControlStateNormal];
    } else {
      [button setAttributedTitle:[[NSAttributedString alloc] init]
              forState:UIControlStateNormal];
    }
    
    [button setBackgroundImage:[self backgroundImageForCard:card]
                      forState:UIControlStateNormal];
    button.enabled = !card.isMatched;
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
  self.lastMoveLabel.attributedText = [self generateLastMoveString];
}

//- (NSAttributedString *)titleForCard:(Card *)card {
//  return card.isChosen ? [self titleForCard:card] : [[NSAttributedString alloc] initWithString:@""];
//}

//- (Deck*)deck {
//  if (!_deck) _deck = [self createDeck];
//  return _deck;
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
  // At the start, game is nil and we need to have the first draw from the deck.
  [self updateUI];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
