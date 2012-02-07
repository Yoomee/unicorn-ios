//
//  AppDelegate.m
//  Chase the Unicorn
//
//  Created by Matthew Atkins on 23/01/2012.
//  Copyright (c) 2012 Yoomee. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "SplashScreenController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize splashScreenController = _splashScreenController;

-(void)setUUID{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults stringForKey:@"uuid"] == nil){
        CFUUIDRef myUUID = CFUUIDCreate(NULL);
        NSString *myUUIDString = CFBridgingRelease(CFUUIDCreateString(NULL, myUUID));
        CFRelease(myUUID);
        [defaults setValue:myUUIDString forKey:@"uuid"];
        [defaults synchronize];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.splashScreenController = [[SplashScreenController alloc] initWithNibName:@"SplashScreenController" bundle:nil];
    self.window.rootViewController = self.splashScreenController;    
    [self.window makeKeyAndVisible];
    [self performSelector:@selector(hideSplashScreen) withObject:nil afterDelay: 2.5f];
    [self setUUID];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    [self.window.rootViewController viewWillAppear:YES];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)hideSplashScreen
{
    self.window.rootViewController = self.viewController;
}

@end
