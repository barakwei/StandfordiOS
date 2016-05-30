//
//  CardView.m
//  Matchismo
//
//  Created by Barak Weiss on 29/05/2016.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "CardView.h"

@implementation CardView

- (void)setFaceUp:(BOOL)faceUp {
  _faceUp = faceUp;
  [self setNeedsDisplay];
}

@end
