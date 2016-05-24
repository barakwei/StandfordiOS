//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Barak Weiss on 24/05/2016.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController()
@property (weak, nonatomic) IBOutlet UITextView *historyText;
@end

@implementation HistoryViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self updateUI];
}

- (void)updateUI {
  [self.historyText setAttributedText:self.textToShow];
}

@end
