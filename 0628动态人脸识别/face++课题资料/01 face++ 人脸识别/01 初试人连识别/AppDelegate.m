//
//  AppDelegate.m
//  01 初试人连识别
//
//  Created by CC老师 on 2017/5/23.
//  Copyright © 2017年 . All rights reserved.
//

#import "AppDelegate.h"
#import "FaceppAPI.h"

#define _API_KEY @"bb1c2998326916f6fd261571f9a06ff3"
#define _API_SECRET @"9RSziAStEXrl_p_XDcyjH8wFkm52di7a"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSString *API_KEY = _API_KEY;
    NSString *API_SECRET = _API_SECRET;
    
    [FaceppAPI initWithApiKey:API_KEY andApiSecret:API_SECRET andRegion:APIServerRegionCN];
    
    //开启debug模式  
    [FaceppAPI setDebugMode:TRUE];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
