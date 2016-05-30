//
//  SetCardView.m
//  Matchismo
//
//  Created by Barak Weiss on 26/05/2016.
//  Copyright © 2016 Barak Weiss. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

#pragma mark - Properties

- (void)setNumber:(NSString *)number {
  _number = number;
  [self setNeedsDisplay];
}

- (void)setSymbol:(NSString *)symbol {
  _symbol = symbol;
  [self setNeedsDisplay];
}

- (void)setShading:(NSString *)shading {
  _shading = shading;
  [self setNeedsDisplay];
}

- (void)setColor:(NSString *)color {
  _color = color;
  [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted {
  _highlighted = highlighted;
  [self setNeedsDisplay];
}

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

#define SHAPE_HEIGHT_FACTOR 6.0
#define SHAPE_WIDITH_FACTOR 2.0

- (CGFloat)shapeHeightFactor { return self.bounds.size.height / SHAPE_HEIGHT_FACTOR; }
- (CGFloat)shapeWidthFactor { return self.bounds.size.width / SHAPE_WIDITH_FACTOR; }

#define STRIPE_DISTANCE_FACTOR 20.0

- (CGFloat)stripeDistanceFactor { return self.bounds.size.width / STRIPE_DISTANCE_FACTOR; }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  // Drawing code
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                         cornerRadius:[self cornerRadius]];
  [roundedRect addClip];
  
  //self.opaque = YES;
  
  UIColor *backgroundColor = [UIColor whiteColor];
  if (_highlighted) {
    backgroundColor = [backgroundColor colorWithAlphaComponent:0.9];
  }
  [backgroundColor setFill];
  UIRectFill(self.bounds);
  
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
  
  CGFloat middleX = (self.bounds.size.width / 2.0);
  
  [[UIColor grayColor] setFill];
  [[UIColor greenColor] setStroke];
  
  [self setFillAndStroke];
  
  if ([self.number isEqualToString:@"1"]) {
    [self drawShapeAndShading:[self rectFromCenterPoint:CGPointMake(middleX, (1.0 * self.bounds.size.height) / 2.0)]];
  } else if ([self.number isEqualToString:@"2"]) {
    [self drawShapeAndShading:[self rectFromCenterPoint:CGPointMake(middleX, (1.0 * self.bounds.size.height) / 3.0)]];
    [self drawShapeAndShading:[self rectFromCenterPoint:CGPointMake(middleX, (2.0 * self.bounds.size.height) / 3.0)]];
  } else if ([self.number isEqualToString:@"3"]) {
    [self drawShapeAndShading:[self rectFromCenterPoint:CGPointMake(middleX, (1.0 * self.bounds.size.height) / 4.0)]];
    [self drawShapeAndShading:[self rectFromCenterPoint:CGPointMake(middleX, (2.0 * self.bounds.size.height) / 4.0)]];
    [self drawShapeAndShading:[self rectFromCenterPoint:CGPointMake(middleX, (3.0 * self.bounds.size.height) / 4.0)]];
  }
}

- (CGRect)rectFromCenterPoint:(CGPoint)centerPoint {
  CGFloat width = [self shapeWidthFactor];
  CGFloat height = [self shapeHeightFactor];
  CGFloat x = centerPoint.x - width/2.0;
  CGFloat y = centerPoint.y - height/2.0;
  
  return CGRectMake(x, y, width, height);
}

- (UIBezierPath *)drawDiamond:(CGRect)rect {
  CGFloat startX = rect.origin.x;
  CGFloat startY = rect.origin.y;
  CGFloat middleX = rect.origin.x + (rect.size.width / 2);
  CGFloat middleY = rect.origin.y + (rect.size.height / 2);
  CGFloat endX = rect.origin.x + rect.size.width;
  CGFloat endY = rect.origin.y + rect.size.height;
  
  UIBezierPath *path = [UIBezierPath bezierPath];
  [path moveToPoint:CGPointMake(middleX, startY)];
  [path addLineToPoint:CGPointMake(endX, middleY)];
  [path addLineToPoint:CGPointMake(middleX, endY)];
  [path addLineToPoint:CGPointMake(startX, middleY)];
  [path closePath];
  return path;
}

// Shamelessly taken from stackoverflow
- (UIBezierPath *)drawSquiggle:(CGRect)rect {
  UIBezierPath *path = [UIBezierPath bezierPath];
  [path moveToPoint:CGPointMake(rect.origin.x + rect.size.width*0.05, rect.origin.y + rect.size.height*0.40)];
  
  [path addCurveToPoint:CGPointMake(rect.origin.x + rect.size.width*0.35, rect.origin.y + rect.size.height*0.25)
          controlPoint1:CGPointMake(rect.origin.x + rect.size.width*0.09, rect.origin.y + rect.size.height*0.15)
          controlPoint2:CGPointMake(rect.origin.x + rect.size.width*0.18, rect.origin.y + rect.size.height*0.10)];
  
  [path addCurveToPoint:CGPointMake(rect.origin.x + rect.size.width*0.75, rect.origin.y + rect.size.height*0.30)
          controlPoint1:CGPointMake(rect.origin.x + rect.size.width*0.40, rect.origin.y + rect.size.height*0.30)
          controlPoint2:CGPointMake(rect.origin.x + rect.size.width*0.60, rect.origin.y + rect.size.height*0.45)];
  
  [path addCurveToPoint:CGPointMake(rect.origin.x + rect.size.width*0.97, rect.origin.y + rect.size.height*0.35)
          controlPoint1:CGPointMake(rect.origin.x + rect.size.width*0.87, rect.origin.y + rect.size.height*0.15)
          controlPoint2:CGPointMake(rect.origin.x + rect.size.width*0.98, rect.origin.y + rect.size.height*0.00)];
  
  [path addCurveToPoint:CGPointMake(rect.origin.x + rect.size.width*0.45, rect.origin.y + rect.size.height*0.85)
          controlPoint1:CGPointMake(rect.origin.x + rect.size.width*0.95, rect.origin.y + rect.size.height*1.10)
          controlPoint2:CGPointMake(rect.origin.x + rect.size.width*0.50, rect.origin.y + rect.size.height*0.95)];
  
  [path addCurveToPoint:CGPointMake(rect.origin.x + rect.size.width*0.25, rect.origin.y + rect.size.height*0.85)
          controlPoint1:CGPointMake(rect.origin.x + rect.size.width*0.40, rect.origin.y + rect.size.height*0.80)
          controlPoint2:CGPointMake(rect.origin.x + rect.size.width*0.35, rect.origin.y + rect.size.height*0.75)];
  
  [path addCurveToPoint:CGPointMake(rect.origin.x + rect.size.width*0.05, rect.origin.y + rect.size.height*0.40)
          controlPoint1:CGPointMake(rect.origin.x + rect.size.width*0.00, rect.origin.y + rect.size.height*1.10)
          controlPoint2:CGPointMake(rect.origin.x + rect.size.width*0.005, rect.origin.y + rect.size.height*0.60)];
  
  [path closePath];
  return path;
}

- (UIBezierPath *)drawOval:(CGRect)rect {
  return [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:[self cornerRadius]];
}

- (void)drawShapeAndShading:(CGRect)rect {
  UIBezierPath *shapePath = nil;
  if ([self.symbol isEqualToString:@"diamond"]) {
    shapePath = [self drawDiamond:rect];
  } else if ([self.symbol isEqualToString:@"squiggle"]) {
    shapePath = [self drawSquiggle:rect];
  } else if ([self.symbol isEqualToString:@"oval"]) {
    shapePath = [self drawOval:rect];
  }

  [self drawShadingForPath:shapePath];
  [shapePath stroke];
  [shapePath fill];
}

- (void)drawShadingForPath:(UIBezierPath *)path {
  if ([self.shading isEqualToString:@"striped"]) {

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGRect rect = path.bounds;
    UIBezierPath *stripes = [UIBezierPath bezierPath];
    
    for (int i = 0; i < rect.size.width; i += [self stripeDistanceFactor])
    {
      [stripes moveToPoint:CGPointMake(rect.origin.x + i, rect.origin.y)];
      [stripes addLineToPoint:CGPointMake(rect.origin.x + i, rect.origin.y + rect.size.height)];
    }
    
    [path addClip];
    [stripes stroke];
    
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
  }
}
                        
- (void)setFillAndStroke {
    // in any case, use stroke
  UIColor *color = [self UIColorForCard];
  [color setStroke];
  if ([self.shading isEqualToString:@"solid"]) {
    [color setFill];
  } else if ([self.shading isEqualToString:@"striped"] || [self.shading isEqualToString:@"open"]) {
    [[UIColor clearColor] setFill];
  }
}

- (UIColor*)UIColorForCard {
  if ([self.color isEqualToString:@"red"]) {
    return [UIColor redColor];
  } else if ([self.color isEqualToString:@"green"]) {
    return [UIColor greenColor];
  } else if ([self.color isEqualToString:@"purple"]) {
    return [UIColor purpleColor];
  }
  return nil;
}

#pragma mark - Initialization

- (void)setup
{
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
  [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  [self setup];
  return self;
}

@end
