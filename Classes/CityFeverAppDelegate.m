//
//  CityFeverAppDelegate.m
//  CityFever
//
//  Created by Stephan Eletzhofer on 15.02.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "debug.h"
#import "CityFeverAppDelegate.h"
#import "CategoryItemViewController.h"


@implementation CityFeverAppDelegate

@synthesize window;
@synthesize navigationController;

+ (void)initialize
{
    DBGS;
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *pListPath = [path stringByAppendingPathComponent: @"Settings.bundle/Root.plist"];
    NSDictionary *pList = [NSDictionary dictionaryWithContentsOfFile: pListPath];

    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];

    NSMutableArray *prefs = [pList objectForKey: @"PreferenceSpecifiers"];
    for (NSDictionary *dict in prefs) {
        NSString *key = [dict objectForKey: @"Key"];
        if (key) {
            DBG(key);
            [defaults setObject:[dict objectForKey:@"DefaultValue"]
                         forKey:key];
        }
    }

    [[NSUserDefaults standardUserDefaults] registerDefaults: defaults];
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DBGS;
    // Override point for customization after application launch.

    // Add the navigation controller's view to the window and display.
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */

    DBGS;
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */

    DBGS;
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    DBGS;
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    DBGS;
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    DBGS;
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [navigationController release];
    [window release];
    [super dealloc];
}



@end
// vim: set ft=objc ts=4 sw=4 expandtab : 
