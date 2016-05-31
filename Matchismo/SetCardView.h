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

typedef NS_ENUM(NSInteger, SetCardNumber) {
  SetCardNumberOne,
  SetCardNumberTwo,
  SetCardNumberThree,
};

typedef NS_ENUM(NSInteger, SetCardSymbol) {
  SetCardSymbolDiamond,
  SetCardSymbolSquiggle,
  SetCardSymbolOval,
};

typedef NS_ENUM(NSInteger, SetCardShading) {
  SetCardShadingSolid,
  SetCardShadingStriped,
  SetCardShadingOpen
};

typedef NS_ENUM(NSInteger, SetCardColor) {
  SetCardColorRed,
  SetCardColorGreen,
  SetCardColorPurple
};

@property (nonatomic) SetCardColor number;
@property (nonatomic) SetCardSymbol symbol;
@property (nonatomic) SetCardShading shading;
@property (nonatomic) SetCardColor color;
@property (nonatomic) BOOL highlighted;

@end
