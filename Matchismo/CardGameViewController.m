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

- (CardMatchingGame *)game {
  if (!_game) _game = [[CardMatchingGame alloc] initWithCardCountAndMatchNumber:[self.cardButtons count]
                                                                    matchNumber:self.matchNumber
                                                                      usingDeck:[self createDeck]];
  return _game;
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
  
  
  NSMutableAttributedString * moveDetails = [[NSMutableAttributedString alloc] init];
  for (Card *lastMoveCard in self.game.lastMoveCards) {
    [moveDetails appendAttributedString:[self titleForCard:lastMoveCard]];
  }
  
  [moveDetails appendAttributedString:[[NSAttributedString alloc] initWithString:self.game.lastMove]];
  
  //self.game.lastMoveCards
  
  // TODO: move to KVO
  //self.lastMoveLabel.text = self.game.lastMove;
  
  self.lastMoveLabel.attributedText = moveDetails;
}

//- (NSAttributedString *)titleForCard:(Card *)card {
//  return card.isChosen ? [self titleForCard:card] : [[NSAttributedString alloc] initWithString:@""];
//}

//- (Deck*)deck {
//  if (!_deck) _deck = [self createDeck];
//  return _deck;
//}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
  [self updateUI];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
