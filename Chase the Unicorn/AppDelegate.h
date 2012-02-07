//
//  AppDelegate.h
//  Chase the Unicorn
//
//  Created by Matthew Atkins on 23/01/2012.
//  Copyright (c) 2012 Yoomee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController, SplashScreenController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) SplashScreenController *splashScreenController;

- (void)hideSplashScreen;


@end
