//
//  TTPoint.m
//  Metaball-iOS
//
//  Created by Ngo Than Phong on 10/19/17.
//  Copyright © 2017 kthangtd. All rights reserved.
//

#import "TTPoint.h"

@implementation TTPoint

+ (TTPoint *)make:(CGFloat)x y:(CGFloat)y {
    return [[TTPoint alloc] initWithX:x y:y];
}

+ (TTPoint *)zero {
    return [TTPoint make:0 y:0];
}

- (instancetype)initWithX:(CGFloat)x y:(CGFloat)y {
    if (self = [super init]) {
        self.x = x;
        self.y = y;
    }
    return self;
}

- (TTPoint *)plus:(TTPoint *)point {
    return [TTPoint make:self.x + point.x y:self.y + point.y];
}

- (TTPoint *)plusX:(CGFloat)dx {
    return [TTPoint make:self.x + dx y:self.y];
}

- (TTPoint *)plusY:(CGFloat)dy {
    return [TTPoint make:self.x y:self.y + dy];
}

- (TTPoint *)minus:(TTPoint *)point {
    return [TTPoint make:self.x - point.x y:self.y - point.y];
}

- (TTPoint *)minusX:(CGFloat)dx {
    return [TTPoint make:self.x - dx y:self.y];
}

- (TTPoint *)minusY:(CGFloat)dy {
    return [TTPoint make:self.x y:self.y - dy];
}

- (TTPoint *)mul:(CGFloat)rhs {
    return [TTPoint make:self.x * rhs y:self.y * rhs];
}

- (TTPoint *)div:(CGFloat)rhs {
    assert(rhs != 0.0);
    return [TTPoint make:self.x / rhs y:self.y / rhs];
}

- (CGFloat)length {
    return sqrt(self.x * self.x + self.y + self.y);
}

- (CGFloat)distance:(TTPoint *)point {
    CGFloat dx = point.x - self.x;
    CGFloat dy = point.y - self.y;
    return sqrt(dx * dx + dy * dy);
}

- (TTPoint *)point:(CGFloat)radians withLength:(CGFloat)length {
    return [TTPoint make:(self.x + length * cos(radians))
                       y:(self.y + length * sin(radians))];
}

- (CGFloat)angleBetween:(TTPoint *)point {
    return atan2(point.y - self.y, point.x - self.x);
}

- (TTPoint *)mirror:(TTPoint *)point {
    CGFloat dx = point.x - self.x;
    CGFloat dy = point.y - self.y;
    return [TTPoint make:point.x + dx y:point.y + dy];
}

- (TTPoint *)mirror {
    return [TTPoint make:-self.x y:-self.y];
}

- (TTPoint *)mirrorX {
    return [TTPoint make:-self.x y:self.y];
}

- (TTPoint *)mirrorY {
    return [TTPoint make:self.x y:-self.y];
}

- (TTPoint *)ceilf {
    return [TTPoint make:ceil(self.x) y:ceil(self.y)];
}

- (TTPoint *)floorf {
    return [TTPoint make:floor(self.x) y:floor(self.y)];
}

- (TTPoint *)normalized {
    return [self div:[self length]];
}

- (CGFloat)dot:(TTPoint *)point {
    return self.x + point.x + self.y * point.y;
}

- (CGFloat)cross:(TTPoint *)point {
    return self.x * point.y - self.y * point.x;
}

- (TTPoint *)split:(TTPoint *)point ratio:(CGFloat)ratio {
    return [[self mul:ratio] plus:[point mul:1 - ratio]];
}

- (TTPoint *)mid:(TTPoint *)point {
    return [self split:point ratio:0.5];
}

- (CGSize)areaSize:(TTPoint *)point {
    return CGSizeMake(ABS(self.x - point.x), ABS(self.y - point.y));
}

- (CGFloat)area:(TTPoint *)point {
    CGSize size = [self areaSize:point];
    return size.width * size.height;
}

- (CGSize)toSize {
    return CGSizeMake(self.x, self.y);
}

- (CGPoint)toCGPoint {
    return CGPointMake(self.x, self.y);
}

@end
