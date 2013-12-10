SWAnimator
==========

#### Usage

	[SWAnimator animateWithDuration:0.3 // any duration
		mediaTiming:SWAnimatorMediaTimingSineEaseIn // a SWAnimatorMediaTiming. see SWAnimator.h for available media timings
		animationBlock:^(float progress) { // a SWAnimationProgressBlock. here you can animate whatever you like, just use you end value * progress
			NSLog(@"%f", progress);
		}];
