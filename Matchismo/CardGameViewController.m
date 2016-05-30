//
//  ViewController.m
//  Matchismo
//
//  Created by Barak Weiss on 5/17/16.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "CardGameViewController.h"
#import "HistoryViewController.h"
#import "CardView.h"
#import "Grid.h"

@interface CardGameViewController ()
//@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) NSMutableAttributedString *history;
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (strong, nonatomic) NSMutableArray<CardView *> *cards;
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

- (NSUInteger)defaultNumberOfCardsOnBoard { // Abstract
  return 0;
}

- (void)updateCardView:(CardView *)view card:(Card *)card { // Abstract
}

- (CardView *)createCardViewForCard:(Card *)card { // Abstract
  return nil;
}

- (NSUInteger)numberOfCardsOnMoreCardsRequest { // Abstract
  return 0;
}

- (NSMutableArray<CardView *> *)cards {
  if (!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (NSAttributedString *)history {
  if (!_history) _history = [[NSMutableAttributedString alloc] initWithString:@""];
  return _history;
}

- (void)appendHistory:(NSAttributedString *)line {
  [self.history insertAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]
                               atIndex:0];
  [self.history insertAttributedString:line
                               atIndex:0];
}

- (CardMatchingGame *)game {
  if (!_game) {
   _game = [[CardMatchingGame alloc]
      initWithCardCountAndMatchNumber:[self defaultNumberOfCardsOnBoard]
                      numberOfMatches:[self matchNumber]
                            usingDeck:[self createDeck]];
  [self dealCards:[self defaultNumberOfCardsOnBoard]]; // redeal the deck
  }
  return _game;
}

- (void) rearrangeCardsOnBoard {
  Grid *grid = [[Grid alloc] init];
  grid.size = self.gameView.bounds.size;
  grid.cellAspectRatio = 2.0/3.0;
  grid.minimumNumberOfCells = self.cards.count;
  
  CGRect a = self.gameView.bounds;
  
  NSUInteger row = 0;
  NSUInteger column = 0;
  NSUInteger i = 0;
  
  if (grid.inputsAreValid) {
    for (CardView *cardView in self.cards) {
      column = (i) % grid.columnCount;
      row = i / grid.columnCount;
      
      CGRect bounds = [grid frameOfCellAtRow:row inColumn:column];
      CGPoint center = [grid centerOfCellAtRow:row inColumn:column];
      
      cardView.frame = [grid frameOfCellAtRow:row inColumn:column];
      //cardView.bounds =
      cardView.center = [grid centerOfCellAtRow:row inColumn:column];
      
      i++;
    }
  }
}

- (CGPoint) cardDeckPosition {
  return CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height + 200);
}

- (void) addCardViewToBoard:(CardView *)view {
  // animate
  // start from bottom right corner
  //view.center = [self cardDeckPosition];
  
  [self.cards addObject:view];
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self
                                         action:@selector(tapCardView:)];
  [view addGestureRecognizer:tap];
  [self.gameView addSubview:view];
  [self rearrangeCardsOnBoard];
}

- (void)dealCards:(NSUInteger)numberOfCards {
  for (int i = 0; i < numberOfCards; i++) {
    Card *newCard = [self.game dealCardFromDeck];
    if (!newCard) break;
    [self addCardViewToBoard:[self createCardViewForCard:newCard]];
  }
}

- (void) removeCardViewFromBoard:(CardView *)view {
  // animate
  [self.cards removeObject:view];
  [view removeFromSuperview];
  [self rearrangeCardsOnBoard];
}

- (IBAction)touchMoreCardsButton:(UIButton *)sender {
  [self dealCards:[self numberOfCardsOnMoreCardsRequest]];
}

- (IBAction)touchDealButton:(UIButton *)sender {
  self.game = nil;
  self.history = nil;
  self.cards = nil;
  [[self.gameView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
  [self updateUI];
  [self rearrangeCardsOnBoard];
}

- (IBAction)tapCardView:(UITapGestureRecognizer *)sender {
  //NSInteger cardIndex = [self.cards indexOfObject:(CardView *)[sender view]];
  CardView *cardView = (CardView *)[sender view];
  [self.game chooseCard:cardView.card];
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
  // Run on a copy so we can remove from the array as we itertate
  NSArray<CardView*> * copyOfCards = self.cards.copy;
  
  for (CardView* cardView in copyOfCards) {
    Card *card = cardView.card;
    [self updateCardView:cardView card:card];
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

#pragma mark Lifecycle

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"Show History"]) {
    if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
      HistoryViewController *hvc = (HistoryViewController *)segue.destinationViewController;
      hvc.textToShow = self.history;
    }
  }
}

- (void)viewDidLayoutSubviews {
  [self rearrangeCardsOnBoard];
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
  // At the start, game is nil and we need to have the first draw from the deck.
  [super viewWillAppear:animated];
  [self rearrangeCardsOnBoard];
  [self updateUI];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
