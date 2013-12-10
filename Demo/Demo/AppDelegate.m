//
//  AppDelegate.m
//  animator
//
//  Created by Simon Westerlund on 10/12/13.
//  Copyright (c) 2013 Simon Westerlund. All rights reserved.
//

#import "AppDelegate.h"
#import "SWAnimator.h"

@interface AppDelegate () {
    UIView *redView;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    redView = [UIView new];
    [redView setFrame:CGRectMake(0, 0, 100, 100)];
    [redView setBackgroundColor:[UIColor redColor]];
    [redView setCenter:[self.window center]];
    [self.window addSubview:redView];
    
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [SWAnimator animateWithDuration:0.4 mediaTiming:SWAnimatorMediaTimingCubicEaseOut animationBlock:^(float progress) {
        [redView.layer setTransform:CATransform3DConcat(CATransform3DMakeRotation(0, 0, 0, 1), CATransform3DMakeTranslation(0, progress * 200, 0))];
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
