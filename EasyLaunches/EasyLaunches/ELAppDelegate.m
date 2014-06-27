//
//  ELAppDelegate.m
//  EasyLaunches
//
//  Created by Ilton  Garcia on 02/06/14.
//  Copyright (c) 2014 EasyLaunches. All rights reserved.
//

#import "ELAppDelegate.h"

@implementation ELAppDelegate
static NSMutableArray* transactions;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self registerFinancialManagers];
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

// Return all the transactions on the App
+ (NSMutableArray *) transactions
{
    @synchronized(self) {
        if(transactions == Nil) transactions = [[NSMutableArray alloc] init];
        return transactions;
    }
}

// Add a transaction o the App
+ (void) addTransactions:(NSString *)transaction
{
    @synchronized(self) {
        [ELAppDelegate transactions];
        [transactions addObject:transaction];
    }
}

- (void) registerFinancialManagers
{
    NSLog(@"FinancialManagers registrations just Started!");
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    
    if(!settingsBundle)
    {
        NSLog(@"Could not find Settings.bundle");
        return;
    }
    
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    
    
    for(NSString *key in [settings allKeys]) {
        NSLog(@"%@",[settings objectForKey:key]);
    }
    

    NSLog(@"manager on Plist: %@", [[settings objectForKey:@"PreferenceSpecifiers"] objectAtIndex:0]);
}
@end
