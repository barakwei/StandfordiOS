//
//  CardView.h
//  Matchismo
//
//  Created by Barak Weiss on 29/05/2016.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface CardView : UIView
@property (nonatomic) BOOL faceUp;
@property (strong, nonatomic) Card *card;

@end
