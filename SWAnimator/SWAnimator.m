//
//  SWAnimator.m
//  animator
//
//  Created by Simon Westerlund on 10/12/13.
//  Copyright (c) 2013 Simon Westerlund. All rights reserved.
//

#import "SWAnimator.h"

#define LOG_ANIMATION_TIME false

@interface SWAnimator ()

@property (nonatomic, copy) SWAnimatonProgressBlock animationBlock;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation SWAnimator

SWAnimator *animator;
SWAnimatorMediaTiming mediaTiming;
CFTimeInterval then; // log length of animation

float progress = 0;
float stepSize = 0;
float duration = 0;

+ (void)animateWithDuration:(CFTimeInterval)_duration
                mediaTiming:(SWAnimatorMediaTiming)_mediaTiming
             animationBlock:(SWAnimatonProgressBlock)animationBlock {
    if (animator) {
        return;
    }
    animator = [SWAnimator new];
    [animator setAnimationBlock:animationBlock];
    
    [animator setDisplayLink:[CADisplayLink displayLinkWithTarget:animator selector:@selector(update:)]];
    [animator.displayLink setFrameInterval:1];
    
    // Calculate each steps size
    stepSize = (1.0f / _duration) / (60.0f / [animator.displayLink frameInterval]);
    
    // Set media timing
    mediaTiming = _mediaTiming;
    
    then = CACurrentMediaTime();
    [animator animate];
}

- (void)animate {
    [animator.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (float)calculateCurrentFrameWithProgress:(float)progress {
    switch (mediaTiming) {
        case SWAnimatorMediaTimingCircularEaseIn:
            return easeInCirc(progress, 0, 1, 1);
        case SWAnimatorMediaTimingCircularEaseOut:
            return easeOutCirc(progress, 0, 1, 1);
        case SWAnimatorMediaTimingCircularEaseInOut:
            return easeInOutCirc(progress, 0, 1, 1);
        case SWAnimatorMediaTimingCubicEaseIn:
            return easeInCubic(progress, 0, 1, 1);
        case SWAnimatorMediaTimingCubicEaseOut:
            return easeOutCubic(progress, 0, 1, 1);
        case SWAnimatorMediaTimingCubicEaseInOut:
            return easeInOutCubic(progress, 0, 1, 1);
        case SWAnimatorMediaTimingExponentialEaseIn:
            return easeInExpo(progress, 0, 1, 1);
        case SWAnimatorMediaTimingExponentialEaseOut:
            return easeOutExpo(progress, 0, 1, 1);
        case SWAnimatorMediaTimingExponentialEaseInOut:
            return easeInOutExpo(progress, 0, 1, 1);
        case SWAnimatorMediaTimingQuadraticEaseIn:
            return easeInQuad(progress, 0, 1, 1);
        case SWAnimatorMediaTimingQuadraticEaseOut:
            return easeOutQuad(progress, 0, 1, 1);
        case SWAnimatorMediaTimingQuadraticEaseInOut:
            return easeInOutQuad(progress, 0, 1, 1);
        case SWAnimatorMediaTimingQuarticEaseIn:
            return easeInQuart(progress, 0, 1, 1);
        case SWAnimatorMediaTimingQuarticEaseOut:
            return easeOutQuart(progress, 0, 1, 1);
        case SWAnimatorMediaTimingQuarticEaseInOut:
            return easeInOutQuad(progress, 0, 1, 1);
        case SWAnimatorMediaTimingQuinticEaseIn:
            return easeInQuint(progress, 0, 1, 1);
        case SWAnimatorMediaTimingQuinticEaseOut:
            return easeOutQuint(progress, 0, 1, 1);
        case SWAnimatorMediaTimingQuinticEaseInOut:
            return easeInOutQuint(progress, 0, 1, 1);
        case SWAnimatorMediaTimingSineEaseIn:
            return easeInSine(progress, 0, 1, 1);
        case SWAnimatorMediaTimingSineEaseOut:
            return easeOutSine(progress, 0, 1, 1);
        case SWAnimatorMediaTimingSineEaseInOut:
            return easeInOutSine(progress, 0, 1, 1);
        case SWAnimatorMediaTimingLinear:
        default: // Linear
            return progress;
    }
}

- (void)update:(CADisplayLink *)displayLink {
    progress += stepSize;
    
    if (progress >= 1.0f) {
        [animator.displayLink invalidate];
        animator.animationBlock(1);
#if LOG_ANIMATION_TIME == true
        NSLog(@"%f", CACurrentMediaTime() - then);
#endif
        progress = 0;
        stepSize = 0;
        animator = nil;
        return;
    }
    animator.animationBlock([animator calculateCurrentFrameWithProgress:progress]);
}

#pragma mark - easing

// t = progress
// b = offset
// c = end value - start value
// d = end value

float linearEasing(float t, float b, float c, float d) {
    return c * t / d + b;
}

float easeInQuad(float t, float b, float c, float d) {
    t /= d;
	return c*t*t + b;
}

float easeOutQuad(float t, float b, float c, float d) {
    t /= d;
	return -c * t*(t-2) + b;
}

float easeInOutQuad(float t, float b, float c, float d) {
    t /= d/2;
	if (t < 1) return c/2*t*t + b;
	t--;
	return -c/2 * (t*(t-2) - 1) + b;
}

float easeInCubic(float t, float b, float c, float d) {
    t /= d;
	return c*t*t*t + b;
}

float easeOutCubic(float t, float b, float c, float d) {
    t /= d;
	t--;
	return c*(t*t*t + 1) + b;
}

float easeInOutCubic(float t, float b, float c, float d) {
    t /= d/2;
	if (t < 1) return c/2*t*t*t + b;
	t -= 2;
	return c/2*(t*t*t + 2) + b;
}

float easeInQuart(float t, float b, float c, float d) {
    t /= d;
	return c*t*t*t*t + b;
}

float easeOutQuart(float t, float b, float c, float d) {
    t /= d;
	t--;
	return -c * (t*t*t*t - 1) + b;
}

float easeInOutQuart(float t, float b, float c, float d) {
    t /= d/2;
	if (t < 1) return c/2*t*t*t*t + b;
	t -= 2;
	return -c/2 * (t*t*t*t - 2) + b;
}

float easeInQuint(float t, float b, float c, float d) {
    t /= d;
	return c*t*t*t*t*t + b;
}

float easeOutQuint(float t, float b, float c, float d) {
    t /= d;
	t--;
	return c*(t*t*t*t*t + 1) + b;
}

float easeInOutQuint(float t, float b, float c, float d) {
    t /= d/2;
	if (t < 1) return c/2*t*t*t*t*t + b;
	t -= 2;
	return c/2*(t*t*t*t*t + 2) + b;
}

float easeInSine(float t, float b, float c, float d) {
	return -c * cosf(t/d * (M_PI/2)) + c + b;
}

float easeOutSine(float t, float b, float c, float d) {
	return c * sinf(t/d * (M_PI/2)) + b;
}

float easeInOutSine(float t, float b, float c, float d) {
	return -c/2 * (cosf(M_PI*t/d) - 1) + b;
}

float easeInExpo(float t, float b, float c, float d) {
	return c * powf( 2, 10 * (t/d - 1) ) + b;
}

float easeOutExpo(float t, float b, float c, float d) {
	return c * ( -powf( 2, -10 * t/d ) + 1 ) + b;
}

float easeInOutExpo(float t, float b, float c, float d) {
	t /= d/2;
	if (t < 1) return c/2 * powf( 2, 10 * (t - 1) ) + b;
	t--;
	return c/2 * ( -powf( 2, -10 * t) + 2 ) + b;
}

float easeInCirc(float t, float b, float c, float d) {
	t /= d;
	return -c * (sqrtf(1 - t*t) - 1) + b;
}

float easeOutCirc(float t, float b, float c, float d) {
	t /= d;
	t--;
	return c * sqrtf(1 - t*t) + b;
}

float easeInOutCirc(float t, float b, float c, float d) {
	t /= d/2;
	if (t < 1) return -c/2 * (sqrtf(1 - t*t) - 1) + b;
	t -= 2;
	return c/2 * (sqrtf(1 - t*t) + 1) + b;
}

@end
