//
//  AppDelegate.m
//  UUIDShortener
//
//  Created by kishikawa katsumi on 2013/10/31.
//  Copyright (c) 2013 kishikawa katsumi. All rights reserved.
//

#import "AppDelegate.h"
#import "UUIDShortener.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSUUID *UUID = [NSUUID UUID];
    NSString *UUIDString = UUID.UUIDString;
    NSLog(@"Original UUID:\t%@", UUIDString);
    
    NSString *shortUUIDString = UUID.shortUUIDString;
    NSLog(@"Short UUID:\t%@", shortUUIDString);
    
    NSLog(@"%@", @"=====");
    NSString *restoredString = [NSUUID UUIDStringFromShortUUIDString:shortUUIDString];
    NSLog(@"Restored UUID:\t%@", restoredString);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UIViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
