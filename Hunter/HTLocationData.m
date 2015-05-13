//
//  HTLocationData.m
//  Hunter
//
//  Created by 李育豪 on 2015/5/6.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import "HTLocationData.h"
//#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import <Parse/Parse.h>
//#import <ParseFacebookUtils/PFFacebookUtils.h>
//#import <PFFacebookUtils.h>

@implementation HTLocationData


+ (HTLocationData *)sharePreyDistance
{
    // the instance of this class is stored here
    static HTLocationData *preyDistance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        preyDistance = [[HTLocationData alloc] init];
    });
    
    // return the instance of this class
    return preyDistance;
}


-(NSArray *)getPreyData {
    
//*************************設定Query找到範圍獵物目標***********************************
    [NSTimer scheduledTimerWithTimeInterval:10
                                     target:self
                                   selector:@selector(getPreyData)
                                   userInfo:nil
                                    repeats:YES];
//    NSLog(@"Is this updating???");
    
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
//    NSArray *array = [[NSArray alloc] init];

    

    __block NSArray *array = [[NSArray alloc] init];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        array = objects;
        //*****************************設定獵物距離*************************************
        
        //set prey1 distance
        PFGeoPoint *tempLocation1 = [array[1] objectForKey:@"userLocation"];
        CLLocation *preylocation1 = [[CLLocation alloc]initWithLatitude:tempLocation1.latitude longitude:tempLocation1.longitude];
        double distance1 = [appDel.userLocation.location distanceFromLocation:preylocation1];
        self.preyDistance1 = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%.01f m",distance1]];
        NSLog(@"appDel.userLocation.location : %@",appDel.userLocation.location);
//        NSLog(@"preyDistance1 is : %@",_preyDistance1);
//        NSLog(@"Is this updating???");

        //set prey2 distance
        PFGeoPoint *tempLocation2 = [array[2] objectForKey:@"userLocation"];
        CLLocation *preylocation2 = [[CLLocation alloc]initWithLatitude:tempLocation2.latitude longitude:tempLocation2.longitude];
        double distance2 = [appDel.userLocation.location distanceFromLocation:preylocation2];
        self.preyDistance2 = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%.01f m",distance2]];
        
        //set prey3 distance
        PFGeoPoint *tempLocation3 = [array[3] objectForKey:@"userLocation"];
        CLLocation *preylocation3 = [[CLLocation alloc]initWithLatitude:tempLocation3.latitude longitude:tempLocation3.longitude];
        double distance3 = [appDel.userLocation.location distanceFromLocation:preylocation3];
        self.preyDistance3 = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%.01f m",distance3]];
        
        //******************************設定獵物大頭貼************************************
        
        //set prey1 photo~~~~~~~~~~~
        NSString *preyImageURL1 = [array[1] objectForKey:@"pictureURL"];
        NSURL *imageURL1 = [NSURL URLWithString:preyImageURL1];
        NSData *imageData1 = [NSData dataWithContentsOfURL:imageURL1];
        _preyPhoto1 = [UIImage imageWithData:imageData1];
        
        //set prey2 photo~~~~~~~~~~~
        NSString *preyImageURL2 = [array[2] objectForKey:@"pictureURL"];
        NSURL *imageURL2 = [NSURL URLWithString:preyImageURL2];
        NSData *imageData2 = [NSData dataWithContentsOfURL:imageURL2];
        _preyPhoto2 = [UIImage imageWithData:imageData2];
        
        //set prey3 photo~~~~~~~~~~~
        NSString *preyImageURL3 = [array[3] objectForKey:@"pictureURL"];
        NSURL *imageURL3 = [NSURL URLWithString:preyImageURL3];
        NSData *imageData3 = [NSData dataWithContentsOfURL:imageURL3];
        _preyPhoto3 = [UIImage imageWithData:imageData3];
        
        //******************************設定獵物階級**************************************
        
        //set prey1 Level
        
        _preyLevel1 = [array[1] objectForKey:@"RankLevel"];
        _preyLevel2 = [array[2] objectForKey:@"RankLevel"];
        _preyLevel3 = [array[3] objectForKey:@"RankLevel"];
        
        //******************************設定獵物是否Attack!**********************************
        
        //check prey attack?

        self.checkAttack1 = (BOOL) [array[1] objectForKey:@"Attack"];
        self.checkAttack2 = (BOOL) [array[2] objectForKey:@"Attack"];
        self.checkAttack3 = (BOOL) [array[3] objectForKey:@"Attack"];
        
        PFRole *role = [[PFRole alloc] initWithName:@"Attack"];
        
        [role saveInBackground];
    }];
    
    return array;
}

@end
