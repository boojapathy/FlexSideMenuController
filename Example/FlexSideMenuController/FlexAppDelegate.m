//
//  FlexAppDelegate.m
//  FlexSideMenuController
//
//  Created by CocoaPods on 08/27/2014.
//  Copyright (c) 2014 boojapathy. All rights reserved.
//

#import "FlexAppDelegate.h"
#import <FlexSideMenuController/FlexSideMenu.h>
#import <FlexSideMenuController/FlexSideMenuAnimator.h>
#import <FlexSideMenuController/FlexSideMenuPopAnimator.h>
#import "FlexViewController.h"

@implementation FlexAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:([NSBundle mainBundle].infoDictionary)[@"UIMainStoryboardFile"] bundle:[NSBundle mainBundle]];
    
    UITableViewController *leftViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"leftMenu"];
    
    UITableViewController *rightViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"leftMenu"];
    FlexViewController *contentViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"contentView"];
    
    NSArray *marrColors=@[(id)[[UIColor colorWithRed:0.8 green:1 blue:0.8 alpha:1] CGColor],(id)[[UIColor whiteColor] CGColor]];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = marrColors;
    gradient.frame = leftViewController.view.bounds;
    //    gradient.anchorPoint = CGPointMake(0.5, 0.5);
    gradient.startPoint = CGPointMake(1.f, 0.5f);
    
    //ends in top right
    gradient.endPoint = CGPointMake(.4f, 1.f);
    
    [leftViewController.view.layer insertSublayer:gradient atIndex:0];
    
    FlexSideMenu *sidebarController = [[FlexSideMenu alloc] initWithContentViewController:contentViewController leftSideMenuController:leftViewController rightSideMenuController:rightViewController usesAutoLayout:true animator:[[FlexSideMenuPopAnimator alloc] init]];
    //    sidebarController.delegate = self;
    sidebarController.view.backgroundColor = [UIColor blackColor];// colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = sidebarController;
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
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
