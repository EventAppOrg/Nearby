//
//  AppDelegate.m
//  Nearby
//
//  Created by Piotr Czubak on 11/19/15.
//  Copyright © 2015 EventAppOrg. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Event.h"
#import "EventUser.h"
#import "EventChat.h"
#import "EventViewController.h"
#import "MenuViewController.h"
#import "HamburgerViewController.h"
#import <Parse/Parse.h>

NSString * const UserDidLoginNotification = @"UserDidLoginNotification";
NSString * const UserDidLogoutNotification = @"UserDidLogoutNotification";


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // set up Parse
    [Event registerSubclass];
    [EventUser registerSubclass];
    [EventChat registerSubclass];
    [Parse setApplicationId:@"5PZvauqNAjxtcB7lhCTdZNqAaruKf8PiKBBnWzmC" clientKey:@"ACefcDZXlXeBdKNncMZIoUthCTtJeiKFDPBEt6ar"];
    
    /* Use PFUser for signing up/logging in
    PFUser *u = [[PFUser alloc] init];
    [u setUsername:@"pf_user"];
    [u setPassword:@"secret"];
    [u signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Signed up suer!");
        } else {
            NSLog(@"Failed: %@", error);
        }
    }];*/
    
    // example for saving custom class - uncomment to test
    /*Event *e = [[Event alloc] init];
    [e setEventName:@"coolest event"];
    [e saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Saved event!");
        } else {
            NSLog(@"Failed: %@", error);
        }
    }];*/

//    LoginViewController *lvc = [[LoginViewController alloc] init];
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:lvc];
//    self.window.rootViewController = navController;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogOut) name:UserDidLogoutNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogIn) name:UserDidLoginNotification object:nil];

    
    PFUser *user = [PFUser currentUser];
    if(user == nil) {
        NSLog(@"Not Logged in");
        LoginViewController *lvc = [[LoginViewController alloc] init];
        UINavigationController *menuNav = [[UINavigationController alloc] initWithRootViewController:lvc];
        self.window.rootViewController = menuNav;
    } else {
        MenuViewController *menuViewController = [[MenuViewController alloc] init];
        UINavigationController *menuNav = [[UINavigationController alloc] initWithRootViewController:menuViewController];
        HamburgerViewController *hamburgerViewController = [[HamburgerViewController alloc] init];
        EventViewController *eventViewController = [[EventViewController alloc] init];
        eventViewController.user = [PFUser currentUser];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:eventViewController];
        hamburgerViewController.menuViewController = menuNav;
        hamburgerViewController.contentViewController = navController;
        menuViewController.hamburgerViewController = hamburgerViewController;
        self.window.rootViewController = hamburgerViewController;
    }

    [self.window makeKeyAndVisible];
    return YES;
}

- (void) userDidLogIn {
    MenuViewController *menuViewController = [[MenuViewController alloc] init];
    UINavigationController *menuNav = [[UINavigationController alloc] initWithRootViewController:menuViewController];
    HamburgerViewController *hamburgerViewController = [[HamburgerViewController alloc] init];
    EventViewController *eventViewController = [[EventViewController alloc] initWithAllEvents];
    eventViewController.user = [PFUser currentUser];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:eventViewController];
    hamburgerViewController.menuViewController = menuNav;
    hamburgerViewController.contentViewController = navController;
    menuViewController.hamburgerViewController = hamburgerViewController;
    self.window.rootViewController = hamburgerViewController;
}


- (void) userDidLogOut {
    LoginViewController *lvc = [[LoginViewController alloc] init];
    UINavigationController *menuNav = [[UINavigationController alloc] initWithRootViewController:lvc];
    self.window.rootViewController = menuNav;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
