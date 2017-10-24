//
//  MetaballView.m
//  Metaball-iOS
//
//  Created by Ngo Than Phong on 10/24/17.
//  Copyright © 2017 kthangtd. All rights reserved.
//

#import "MetaballView.h"
#import "TTCircle.h"

@interface MetaballView ()

@end

@implementation MetaballView

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self generalInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self generalInit];
    }
    return self;
}

- (void)dealloc {
    [self pauseAnimation];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.strokeColor = nil;
    self.fillColor = nil;
    self.loadingAnimation = nil;
}

- (void)removeFromSuperview {
    [self pauseAnimation];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super removeFromSuperview];
}

+ (Class)layerClass {
    return [MetaballLayer class];
}

- (void)generalInit {
    
    [self initDefaultValue];
    
    self.backgroundColor = [UIColor clearColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resumeAnimation)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pauseAnimation)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    [self startAnimation];
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    if (hidden) {
        [self pauseAnimation];
    } else {
        [self resumeAnimation];
    }
}

- (void)initDefaultValue {
    self.loadingStyle = LoadingStyleFill;
    self.fillColor = [DefaultConfig get].fillColor;
    self.strokeColor = [DefaultConfig get].strokeColor;
    self.ballRadius = [DefaultConfig get].radius;
    self.maxDistance = [DefaultConfig get].maxDistance;
    self.curveAngle = [DefaultConfig get].curveAngle;
    self.handleLenRate = [DefaultConfig get].handleLenRate;
    self.spacing = [DefaultConfig get].spacing;
}

- (void)setLoadingStyle:(LoadingStyle)loadingStyle {
    _loadingStyle = loadingStyle;
    ((MetaballLayer *)self.layer).loadingStyle = loadingStyle;
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    ((MetaballLayer *)self.layer).fillColor = fillColor;
}

- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
    ((MetaballLayer *)self.layer).strokeColor = strokeColor;
}

- (void)setBallRadius:(CGFloat)ballRadius {
    _ballRadius = ballRadius;
    ((MetaballLayer *)self.layer).radius = ballRadius;
}

- (void)setMaxDistance:(CGFloat)maxDistance {
    _maxDistance = maxDistance;
    ((MetaballLayer *)self.layer).maxDistance = maxDistance;
}

- (void)setCurveAngle:(CGFloat)curveAngle {
    _curveAngle = curveAngle;
    ((MetaballLayer *)self.layer).curveAngle = curveAngle;
}

- (void)setHandleLenRate:(CGFloat)handleLenRate {
    _handleLenRate = handleLenRate;
    ((MetaballLayer *)self.layer).handleLenRate = handleLenRate;
}

- (void)setSpacing:(CGFloat)spacing {
    _spacing = spacing;
    ((MetaballLayer *)self.layer).spacing = spacing;
}

- (void)startAnimation {
    MetaballLayer * loadingLayer = (MetaballLayer *)self.layer;
    
    self.loadingAnimation = [CABasicAnimation animationWithKeyPath:@"movingBallCenterX"];
    self.loadingAnimation.duration = 1.5;
    self.loadingAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    self.loadingAnimation.fromValue = [NSNumber numberWithFloat:loadingLayer.radius];
    self.loadingAnimation.toValue = [NSNumber numberWithFloat:loadingLayer.maxLength - loadingLayer.radius];
    self.loadingAnimation.repeatCount = INFINITY;
    self.loadingAnimation.autoreverses = YES;
    [loadingLayer addAnimation:self.loadingAnimation forKey:@"loading"];
}

- (void)resetAnimation {
    [self.layer removeAnimationForKey:@"loading"];
    [self startAnimation];
}

- (void)resumeAnimation {
    if (self.loadingAnimation != nil) {
        [self.layer addAnimation:self.loadingAnimation forKey:@"loading"];
    }
    [self resumeLayer:self.layer];
}

- (void)pauseAnimation {
    self.loadingAnimation = (CABasicAnimation *)[[self.layer animationForKey:@"loading"] copy];
    [self pauseLayer:self.layer];
}

- (void)pauseLayer:(CALayer *)layer {
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime()
                                         fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

- (void)resumeLayer:(CALayer *)layer {
    CFTimeInterval pausedTime = layer.timeOffset;
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime()
                                             fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

@end
