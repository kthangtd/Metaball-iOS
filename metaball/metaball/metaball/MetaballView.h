//
//  MetaballView.h
//  Metaball-iOS
//
//  Created by Ngo Than Phong on 10/24/17.
//  Copyright © 2017 kthangtd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MetaballLayer.h"

@interface MetaballView : UIView

@property (nonatomic, strong) CABasicAnimation * loadingAnimation;

@property (nonatomic, assign) LoadingStyle loadingStyle;

@property (nonatomic, strong) UIColor * fillColor;

@property (nonatomic, strong) UIColor * strokeColor;

@property (nonatomic, assign) CGFloat ballRadius;

@property (nonatomic, assign) CGFloat maxDistance;

@property (nonatomic, assign) CGFloat curveAngle;

@property (nonatomic, assign) CGFloat handleLenRate;

@property (nonatomic, assign) CGFloat spacing;

- (void)startAnimation;

- (void)resetAnimation;

- (void)resumeAnimation;

- (void)pauseAnimation;

@end

