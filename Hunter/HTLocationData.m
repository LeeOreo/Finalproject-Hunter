//
//  HTLocationData.m
//  Hunter
//
//  Created by 李育豪 on 2015/5/6.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import "HTLocationData.h"
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <PFFacebookUtils.h>


@implementation HTLocationData


-(NSArray *)getPreyLocationData {
        
    MKPointAnnotation *point;
    
    //透過UIApplication sharedApplication 設定 Global 變數
    AppDelegate* appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    point.coordinate = CLLocationCoordinate2DMake(appDel.userLocation.location.coordinate.latitude,appDel.userLocation.location.coordinate.longitude);
    
    //set myGeoPoint
    PFGeoPoint *myGeoPoint = [PFGeoPoint geoPointWithLatitude:appDel.userLocation.location.coordinate.latitude longitude:appDel.userLocation.location.coordinate.longitude];
    
    // Create a query for places
    PFQuery *query = [PFUser query];
    
    // Interested in locations near user.
    [query whereKey:@"userLocation" nearGeoPoint:myGeoPoint];
    
    // Limit what could be a lot of points.
    query.limit = 4;
    NSArray *array = [query findObjects];
    NSLog(@"array %d",array.count);
    
    return array;
}





@end
