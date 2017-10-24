//
//  TTCircle.m
//  Metaball-iOS
//
//  Created by Ngo Than Phong on 10/19/17.
//  Copyright © 2017 kthangtd. All rights reserved.
//

#import "TTCircle.h"

#pragma mark ---- < TTCircle >

@implementation TTCircle

- (instancetype)initWithDefaultValue
{
    self = [super init];
    if (self) {
        [self setDefaultValue];
    }
    return self;
}

- (void)dealloc {
    self.center = nil;
}

+ (TTCircle *)create {
    return [[TTCircle alloc] initWithDefaultValue];
}

- (void)setDefaultValue {
    self.center = [TTPoint zero];
    self.radius = 0.0;
}

- (CGRect)frame {
    return CGRectMake(self.center.x - self.radius, self.center.y - self.radius, 2 * self.radius, 2 * self.radius);
}

@end

#pragma mark ---- < DefaultConfig >

static DefaultConfig * sInstance = nil;

@implementation DefaultConfig

- (instancetype)initWithDefaultValue {
    self = [super init];
    if (self) {
        [self setDefaultValue];
    }
    return self;
}

+ (DefaultConfig *)get {
    if (sInstance == nil) {
        sInstance = [[DefaultConfig alloc] initWithDefaultValue];
    }
    return sInstance;
}

- (void)setDefaultValue {
    _radius = 8.0;
    _fillColor = [UIColor colorWithRed:5.0/255.0 green:211.0/255.0 blue:128.0/255.0 alpha:1];
    _strokeColor = [UIColor colorWithRed:5.0/255.0 green:211.0/255.0 blue:128.0/255.0 alpha:1];
    _curveAngle = 0;
    _maxDistance = 30.0;
    _handleLenRate = 0.0;
    _spacing = 20.0;
}

@end
