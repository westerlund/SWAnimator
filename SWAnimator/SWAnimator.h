//
//  SWAnimator.h
//  animator
//
//  Created by Simon Westerlund on 10/12/13.
//  Copyright (c) 2013 Simon Westerlund. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SWAnimatonProgressBlock)(float progress);
typedef NS_ENUM(NSInteger, SWAnimatorMediaTiming) {
    SWAnimatorMediaTimingLinear = 0,
    SWAnimatorMediaTimingQuadraticEaseIn,
    SWAnimatorMediaTimingQuadraticEaseOut,
    SWAnimatorMediaTimingQuadraticEaseInOut,
    SWAnimatorMediaTimingCubicEaseIn,
    SWAnimatorMediaTimingCubicEaseOut,
    SWAnimatorMediaTimingCubicEaseInOut,
    SWAnimatorMediaTimingQuarticEaseIn,
    SWAnimatorMediaTimingQuarticEaseOut,
    SWAnimatorMediaTimingQuarticEaseInOut,
    SWAnimatorMediaTimingQuinticEaseIn,
    SWAnimatorMediaTimingQuinticEaseOut,
    SWAnimatorMediaTimingQuinticEaseInOut,
    SWAnimatorMediaTimingSineEaseIn,
    SWAnimatorMediaTimingSineEaseOut,
    SWAnimatorMediaTimingSineEaseInOut,
    SWAnimatorMediaTimingExponentialEaseIn,
    SWAnimatorMediaTimingExponentialEaseOut,
    SWAnimatorMediaTimingExponentialEaseInOut,
    SWAnimatorMediaTimingCircularEaseIn,
    SWAnimatorMediaTimingCircularEaseOut,
    SWAnimatorMediaTimingCircularEaseInOut
};

@interface SWAnimator : NSObject


+ (void)animateWithDuration:(NSTimeInterval)duration
                mediaTiming:(SWAnimatorMediaTiming)mediaTiming
             animationBlock:(SWAnimatonProgressBlock)animationBlock;
- (void)animate;

@end

