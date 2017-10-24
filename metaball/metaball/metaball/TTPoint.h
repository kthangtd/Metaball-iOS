//
//  TTPoint.h
//  Metaball-iOS
//
//  Created by Ngo Than Phong on 10/19/17.
//  Copyright © 2017 kthangtd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TTPoint : NSObject

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

+ (TTPoint *)zero;

+ (TTPoint *)make:(CGFloat)x y:(CGFloat)y;

- (instancetype) __unavailable init;

- (instancetype)initWithX:(CGFloat)x y:(CGFloat)y;

- (TTPoint *)plus:(TTPoint *)point;
- (TTPoint *)plusX:(CGFloat)dx;
- (TTPoint *)plusY:(CGFloat)dy;

- (TTPoint *)minus:(TTPoint *)point;
- (TTPoint *)minusX:(CGFloat)dx;
- (TTPoint *)minusY:(CGFloat)dy;

- (TTPoint *)mul:(CGFloat)rhs;

- (TTPoint *)div:(CGFloat)rhs;

- (CGFloat)length;

- (CGFloat)distance:(TTPoint *)point;

- (TTPoint *)point:(CGFloat)radians withLength:(CGFloat)length;

- (CGFloat)angleBetween:(TTPoint *)point;

- (TTPoint *)mirror:(TTPoint *)point;
- (TTPoint *)mirror;
- (TTPoint *)mirrorX;
- (TTPoint *)mirrorY;

- (TTPoint *)ceilf;

- (TTPoint *)floorf;

- (TTPoint *)normalized;

- (CGFloat)dot:(TTPoint *)point;

- (CGFloat)cross:(TTPoint *)point;

- (TTPoint *)split:(TTPoint *)point ratio:(CGFloat)ratio;

- (TTPoint *)mid:(TTPoint *)point;

- (CGSize)areaSize:(TTPoint *)point;

- (CGFloat)area:(TTPoint *)point;

- (CGSize)toSize;

- (CGPoint)toCGPoint;

@end
