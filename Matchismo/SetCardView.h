//
//  SetCardView.h
//  Matchismo
//
//  Created by Barak Weiss on 26/05/2016.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"

@interface SetCardView : CardView

@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;
@property (nonatomic) BOOL highlighted;

@end
