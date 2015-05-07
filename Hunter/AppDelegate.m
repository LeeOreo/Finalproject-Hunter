//
//  AppDelegate.m
//  Hunter
//
//  Created by 李育豪 on 2015/4/28.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <CoreLocation/CoreLocation.h>
#import "HTConst.h"

@interface AppDelegate () <CLLocationManagerDelegate>


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // ****************************************************************************
    [Parse setApplicationId:@"B89mcY6h95t0PxJLos80WHyA3qP7WQpAmwgsiisi"
                  clientKey:@"o2IcXKm5R0jtD0vZb9itUF4xFxx1Xu1M6GYTaFWg"];
    // ****************************************************************************
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [PFFacebookUtils initializeFacebook];
    [self getUserLocation];
    
    
    
    // 設定攻擊範圍
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:UserDefaultsFilterDistanceKey] == nil) {
        // If we have no accuracy in defaults, set it to 1000 feet.
        [userDefaults setDouble:UserDefaultFilterDistance forKey:UserDefaultsFilterDistanceKey];
    }


    return YES;
}



- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation{
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [PFUser.currentUser setObject:[NSNull null] forKey: @"userLocation"];
    [[PFUser currentUser] saveInBackground];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[NSUserDefaults standardUserDefaults] synchronize];
//    [PFUser logOutInBackground];
//    [PFUser logOut];
    [PFUser.currentUser setObject:[NSNull null] forKey: @"userLocation"];
    [[PFUser currentUser] saveInBackground];
}

#pragma mark - userLocation

- (void)getUserLocation {
    if (_userLocation ==nil) {
        _userLocation = [[CLLocationManager alloc] init];
        _userLocation.delegate = self;
        
        _userLocation.desiredAccuracy = kCLLocationAccuracyBest;
        // Set a movement threshold for new events.
        _userLocation.distanceFilter = kCLLocationAccuracyNearestTenMeters;
        // Set a movement threshold for new events.
        _userLocation.distanceFilter = 500; // meters
        //詢問是否要給APP定位權限
        [_userLocation requestWhenInUseAuthorization];
        //start getUserLocation
        [_userLocation startUpdatingLocation];

//是否在這邊上傳座標到parse?
//先在parse創出geopoint的欄位?

        NSLog(@"print %6f, %6f",_userLocation.location.coordinate.latitude,_userLocation.location.coordinate.longitude);
    }else
        NSLog(@"no");

}


    //upload coordinate to parse~~~~~~~~~~
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {

    PFUser *user = [PFUser currentUser];
    if (user) {
        // User's location
        PFGeoPoint *userGeoPoint = [PFGeoPoint geoPointWithLatitude: _userLocation.location.coordinate.latitude longitude: _userLocation.location.coordinate.longitude];
        [user setObject: userGeoPoint forKey: @"userLocation"];
        [user saveInBackground];

    }
    NSLog(@"%6f, %6f",_userLocation.location.coordinate.latitude,_userLocation.location.coordinate.longitude);
}


@end
    
