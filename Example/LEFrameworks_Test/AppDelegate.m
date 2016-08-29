//
//  AppDelegate.m
//  LEFrameworks_Test
//
//  Created by emerson larry on 16/7/5.
//  Copyright © 2016年 LarryEmerson. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LEFrameworks.h"

@interface AppDelegate ()
@end
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *searchText=@"\\@asd :\\@qqq :\\@:@asd :\\@asd \\";
    NSString *match=@"@(.*?) :";
    
    NSRange range=[searchText rangeOfString:match options:NSRegularExpressionSearch];
    if(range.location!=NSNotFound){
        LELog(@"range:%@",[searchText substringWithRange:range]);
    }
    LELogObject(NSStringFromRange(range));
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",match];
    LELogInt([numberPre evaluateWithObject:searchText]);
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:match options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *result = [regex firstMatchInString:searchText options:0 range:NSMakeRange(0, [searchText length])];
    if (result) {
        LELog(@"%@", [searchText substringWithRange:result.range]);
    }else{
        LELogObject(result);
    } 
    
    //    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //    self.window.backgroundColor = [UIColor lightGrayColor];
    //    ViewController *viewController=[[ViewController alloc] init];
    //    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewController];
    //    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    //    [nav setNavigationBarHidden:NO animated:YES];
    //    [self.window setRootViewController:nav];
    //    [self.window makeKeyAndVisible]; 
    return YES;
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
