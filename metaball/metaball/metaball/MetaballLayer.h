//
//  MetaballLayer.h
//  Metaball-iOS
//
//  Created by Ngo Than Phong on 10/24/17.
//  Copyright © 2017 kthangtd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LoadingStyle) {
    LoadingStyleStroke,
    LoadingStyleFill
};

@interface MetaballLayer : CALayer

@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, assign, readonly) CGFloat maxLength;

@property (nonatomic, assign) CGFloat maxDistance;

@property (nonatomic, assign) CGFloat curveAngle;

@property (nonatomic, assign) CGFloat spacing;

@property (nonatomic, assign) CGFloat handleLenRate;

@property (nonatomic, strong) UIColor * fillColor;

@property (nonatomic, strong) UIColor * strokeColor;

@property (nonatomic, assign) LoadingStyle loadingStyle;

@property (nonatomic, assign) CGFloat movingBallCenterX;

@end
