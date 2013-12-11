SWAnimator
==========

_Are you too tired of not getting any key frames from UIView animations? Are you too interested of doing your own animations but still use easing? Are you too tired of the cold in Sweden this time of year?_

May I present to you, the SWAnimator!

It may not look much, but it's still something. You simple run `-[SWAnimator animateWithDuration:mediaTiming:animationBlock]` and the block you provide gets called 60 times per second wich contains a current progress, which you then can hook to your favorite views.

It's still in early development so it doesn't support stuff like aborting animations, cutting trees and making coffee.

#### Usage

	[SWAnimator animateWithDuration:0.3 // any duration
		mediaTiming:SWAnimatorMediaTimingSineEaseIn // a SWAnimatorMediaTiming. see SWAnimator.h for available media timings
		animationBlock:^(float progress) { // a SWAnimationProgressBlock. here you can animate whatever you like, just use you end value * progress
			NSLog(@"%f", progress);
		}];
