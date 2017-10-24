//
//  MetaballLayer.m
//  Metaball-iOS
//
//  Created by Ngo Than Phong on 10/24/17.
//  Copyright © 2017 kthangtd. All rights reserved.
//

#import "MetaballLayer.h"
#import "TTCircle.h"

#define MOVE_BALL_SCALE_RATE 0.75
#define ITEM_COUNT 2
#define SCALE_RATE 0.8

@interface MetaballLayer ()

@property (nonatomic, strong) NSMutableArray<TTCircle *> * circlePaths;

@end

@implementation MetaballLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initDefaultValue];
        [self generalInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initDefaultValue];
        [self generalInit];
    }
    return self;
}

- (instancetype)initWithLayer:(id)layer {
    if ([layer isKindOfClass:[MetaballLayer class]]) {
        MetaballLayer * mLayer = (MetaballLayer *)layer;
        self.circlePaths = [NSMutableArray array];
        self.movingBallCenterX = mLayer.movingBallCenterX;
        self.loadingStyle = mLayer.loadingStyle;
        self.fillColor = mLayer.fillColor;
        self.strokeColor = mLayer.strokeColor;
        self.radius = mLayer.radius;
        self.maxDistance = mLayer.maxDistance;
        self.curveAngle = mLayer.curveAngle;
        self.handleLenRate = mLayer.handleLenRate;
        self.spacing = mLayer.spacing;
    } else {
        [self initDefaultValue];
    }
    
    if (self = [super initWithLayer:layer]) {
        [self generalInit];
    }
    return self;
}

- (void)dealloc {
    self.fillColor = nil;
    self.strokeColor = nil;
    if (self.circlePaths != nil) {
        [self.circlePaths removeAllObjects];
        self.circlePaths = nil;
    }
}

- (void)generalInit {
    self.needsDisplayOnBoundsChange = YES;
    for (int i = 0; i < ITEM_COUNT; i++) {
        TTCircle * circlePath = [TTCircle create];
        circlePath.center = [TTPoint make:(self.radius * 2 + self.spacing) * i
                                        y:self.radius * (1.0 + SCALE_RATE)];
        circlePath.radius = i == 0 ? self.radius * MOVE_BALL_SCALE_RATE : self.radius;
        [self.circlePaths addObject:circlePath];
    }
}

- (void)initDefaultValue {
    self.circlePaths = [NSMutableArray array];
    self.radius = [DefaultConfig get].radius;
    self.maxDistance = [DefaultConfig get].maxDistance;
    self.curveAngle = [DefaultConfig get].curveAngle;
    self.spacing = [DefaultConfig get].spacing;
    self.handleLenRate = [DefaultConfig get].handleLenRate;
    self.fillColor = [DefaultConfig get].fillColor;
    self.strokeColor = [DefaultConfig get].strokeColor;
    self.loadingStyle = LoadingStyleFill;
    self.movingBallCenterX = 0.0;
}

- (CGFloat)maxLength {
    return (self.radius * 2 + self.spacing) * ITEM_COUNT;
}

- (void)setSpacing:(CGFloat)spacing {
    _spacing = spacing;
    [self adjustSpacing:spacing];
}

- (void)setMovingBallCenterX:(CGFloat)movingBallCenterX {
    _movingBallCenterX = movingBallCenterX;
    if (self.circlePaths.count > 0) {
        self.circlePaths[0].center = [TTPoint make:movingBallCenterX
                                                 y:self.circlePaths[0].center.y];
    }
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"movingBallCenterX"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (id<CAAction>)actionForKey:(NSString *)event {
    if ([event isEqualToString:@"movingBallCenterX"]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:event];
        animation.fromValue = [[self presentationLayer] valueForKey:event];
        
        return animation;
    }
    return [super actionForKey:event];
}

- (void)drawInContext:(CGContextRef)ctx {
    UIGraphicsPushContext(ctx);
    
    TTCircle * movingCircle = self.circlePaths[0];
    movingCircle.center = [TTPoint make:self.movingBallCenterX
                                      y:movingCircle.center.y];
    
    [self renderPath:[UIBezierPath bezierPathWithOvalInRect:movingCircle.frame]];
    for (int j = 1; j < self.circlePaths.count; j++) {
        [self metaball:j i:0
            curveAngle:self.curveAngle
         handleLenRate:self.handleLenRate
           maxDistance:self.maxDistance];
    }
    
    UIGraphicsPopContext();
}

- (void)adjustSpacing:(CGFloat)spacing {
    if (ITEM_COUNT > 1 && self.circlePaths.count > 1) {
        for (int i = 1; i < ITEM_COUNT; i++) {
            TTCircle * circlePath = self.circlePaths[i];
            circlePath.center = [TTPoint make:(self.radius * 2 + self.spacing) * i
                                            y:self.radius * (1.0 + SCALE_RATE)];
        }
    }
}

- (void)renderPath:(UIBezierPath *)path {
    [self.fillColor setFill];
    [self.strokeColor setStroke];
    self.loadingStyle == LoadingStyleFill ? [path fill] : [path stroke];
}

- (void)metaball:(int)j i:(int)i curveAngle:(CGFloat)curveAngle
   handleLenRate:(CGFloat)handleLenRate maxDistance:(CGFloat)maxDistance {
    TTCircle * circle1 = self.circlePaths[i];
    TTCircle * circle2 = self.circlePaths[j];
    
    TTPoint * center1 = circle1.center;
    TTPoint * center2 = circle2.center;
    
    CGFloat d = [center1 distance:center2];
    
    CGFloat radius1 = [circle1 radius];
    CGFloat radius2 = [circle2 radius];
    
    if (radius1 == NAN || radius2 == NAN) {
        radius1 = circle1.radius;
        radius2 = circle2.radius;
    }
    
    if (d > maxDistance) {
        [self renderPath:[UIBezierPath bezierPathWithOvalInRect:circle2.frame]];
    } else {
        CGFloat scale2 = 1 + SCALE_RATE * (1 - d / maxDistance);
        radius2 *= scale2;
        [self renderPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(circle2.center.x - radius2,
                                                                           circle2.center.y - radius2,
                                                                           2 * radius2, 2 * radius2)]];
    }
}

@end
