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
@property (strong, nonatomic) UIDynamicAnimator *stackAnimator;
@property (strong, nonatomic) NSMutableArray<UISnapBehavior *> * stackSnaps;
@property (nonatomic) BOOL stacked;
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

- (UIDynamicAnimator *)stackAnimator {
  if (!_stackAnimator) {
    _stackAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:_gameView];
  }
  return _stackAnimator;
}

- (NSMutableArray<UISnapBehavior *> *)stackSnaps; {
  if (!_stackSnaps) {
    _stackSnaps = [[NSMutableArray alloc] init];
  }
  return _stackSnaps;
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
  
  NSUInteger i = 0;
  
  if (grid.inputsAreValid) {
    for (CardView *cardView in self.cards) {
      [UIView transitionWithView:cardView
                        duration:0.3
                         options:UIViewAnimationOptionCurveEaseIn
                      animations:^ {
                        NSUInteger column = (i) % grid.columnCount;
                        NSUInteger row = i / grid.columnCount;
                        cardView.frame = [grid frameOfCellAtRow:row inColumn:column];
                        cardView.center = [grid centerOfCellAtRow:row inColumn:column];
                      }
                      completion:nil];
      i++;
    }
  }
}

- (CGPoint) mainCardDeckPosition {
  return CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height + 200);
}

- (CGPoint) garbageCardDeckPosition {
  return CGPointMake(self.view.bounds.size.width / 2.0, -200);
}

- (void) addCardViewToBoard:(CardView *)view {
  // animate
  // start from bottom right corner
  view.center = [self mainCardDeckPosition];
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self
                                         action:@selector(tapCardView:)];
  [view addGestureRecognizer:tap];
  
  
  UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]
                                    initWithTarget:self
                                    action:@selector(panCard:)];
  
  [view addGestureRecognizer:pan];
  
  [self.cards addObject:view];
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
  [UIView transitionWithView:view
                    duration:0.4
                     options:UIViewAnimationOptionCurveEaseIn
                  animations:^ {
                    view.center = [self garbageCardDeckPosition];
                  }
                  completion:^ (BOOL fin) {
                    [view removeFromSuperview];
                    [self rearrangeCardsOnBoard];
                  }];
}

- (IBAction)touchMoreCardsButton:(UIButton *)sender {
  self.stacked = NO;
  [self dealCards:[self numberOfCardsOnMoreCardsRequest]];
}

- (IBAction)touchDealButton:(UIButton *)sender {
  // Iterate on copy b/c we remove from array
  NSArray<CardView*> * copyOfCards = self.cards.copy;
  
  for (CardView* cardView in copyOfCards) {
    [self removeCardViewFromBoard:cardView];
  }
  
  self.stacked = NO;
  self.game = nil;
  self.history = nil;
  self.cards = nil;
  [self updateUI];
  [self rearrangeCardsOnBoard];
}

- (IBAction)tapCardView:(UITapGestureRecognizer *)sender {
  if (self.stacked) { // stop stack
    self.stacked = NO;
    [self rearrangeCardsOnBoard];
  } else {
    // handle normal card tap
    CardView *cardView = (CardView *)[sender view];
    [self.game chooseCard:cardView.card];
    [self updateUI];
    [self appendHistory:[self generateLastMoveString]];
  }
}

- (IBAction)pinchBoard:(UIPinchGestureRecognizer *)sender {
  if (self.stacked) return;
  
  if (sender.state == UIGestureRecognizerStateBegan) {
    [UIView transitionWithView:self.view
                      duration:0.4
                       options:UIViewAnimationOptionCurveEaseIn
                    animations:^ {
                      for (CardView* cardView in [self cards]) {
                        cardView.center = self.gameView.center;
                      }

                    }
                    completion:nil];
    self.stacked = YES;
    
  } else if (sender.state == UIGestureRecognizerStateEnded) {
    //[self rearrangeCardsOnBoard];
  }
}

- (IBAction)panCard:(UIPanGestureRecognizer *)sender {
  if (!self.stacked) return;
  
  CGPoint gesturePoint = [sender locationInView:self.gameView];
  if (sender.state == UIGestureRecognizerStateBegan) {
    self.stackAnimator = nil;
    self.stackSnaps = nil;

    for (CardView* cardView in [self cards]) {
      UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:cardView
                                                      snapToPoint:gesturePoint];
      
      [self.stackSnaps addObject:snap];
      [self.stackAnimator addBehavior:snap];
    }
    
  } else if (sender.state == UIGestureRecognizerStateChanged) {
    for (UISnapBehavior *snap in self.stackSnaps) {
      snap.snapPoint = gesturePoint;
    }
  } else if (sender.state == UIGestureRecognizerStateEnded ||
             sender.state == UIGestureRecognizerStateFailed) {

  }
}

- (IBAction)tapBoard:(UITapGestureRecognizer *)sender {
  [self rearrangeCardsOnBoard];
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
  
  UIPinchGestureRecognizer *pinchRec = [[UIPinchGestureRecognizer alloc]
                                     initWithTarget:self
                                      action:@selector(pinchBoard:)];
  [self.view addGestureRecognizer:pinchRec];
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
