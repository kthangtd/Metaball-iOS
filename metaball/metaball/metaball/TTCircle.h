//
//  TTCircle.h
//  Metaball-iOS
//
//  Created by Ngo Than Phong on 10/19/17.
//  Copyright © 2017 kthangtd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTPoint.h"

@interface TTCircle : NSObject

@property (nonatomic, strong) TTPoint * center;

@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, assign, readonly) CGRect frame;

+ (TTCircle *)create;

- (instancetype) __unavailable init;

@end

@interface DefaultConfig : NSObject

@property (nonatomic, assign, readonly) CGFloat radius;

@property (nonatomic, strong, readonly) UIColor * fillColor;

@property (nonatomic, strong, readonly) UIColor * strokeColor;

@property (nonatomic, assign, readonly) CGFloat curveAngle;

@property (nonatomic, assign, readonly) CGFloat maxDistance;

@property (nonatomic, assign, readonly) CGFloat handleLenRate;

@property (nonatomic, assign, readonly) CGFloat spacing;

- (instancetype) __unavailable init;

+ (DefaultConfig *)get;

@end

