//
//  HT3PreyViewController.m
//  Hunter
//
//  Created by 李育豪 on 2015/5/6.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import "HT3PreyViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <CoreLocation/CoreLocation.h>

@interface HT3PreyViewController ()

@end

@implementation HT3PreyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    
    
    //set prey1 photo~~~~~~~~~~~
    NSString *preyImageURL1 = [array[0] objectForKey:@"pictureURL"];
    NSURL *imageURL1 = [NSURL URLWithString:preyImageURL1];
    NSData *imageData1 = [NSData dataWithContentsOfURL:imageURL1];
    _preyImage1.image = [UIImage imageWithData:imageData1];
    
    //set prey2 photo~~~~~~~~~~~
    NSString *preyImageURL2 = [array[1] objectForKey:@"pictureURL"];
    NSURL *imageURL2 = [NSURL URLWithString:preyImageURL2];
    NSData *imageData2 = [NSData dataWithContentsOfURL:imageURL2];
    _preyImage2.image = [UIImage imageWithData:imageData2];
    
    //set prey3 photo~~~~~~~~~~~
    NSString *preyImageURL3 = [array[2] objectForKey:@"pictureURL"];
    NSURL *imageURL3 = [NSURL URLWithString:preyImageURL3];
    NSData *imageData3 = [NSData dataWithContentsOfURL:imageURL3];
    _preyImage3.image = [UIImage imageWithData:imageData3];
    
    
    
    
    
    //set prey1Distance~~~~~~~~~                 這裡有問題
//    CLLocation *preylocation1 = [array[0] objectForKey:@"userLocation"];
//    
//    CLLocationDistance distance = [appDel.userLocation.location distanceFromLocation:preylocation1];
//    _preyDistance1.text = [NSString stringWithFormat:@"%f",distance];
//    
    //set prey2Distance~~~~~~~~~
    //set prey3Distance~~~~~~~~~
}

    //send preyInfo to mapVC

- (IBAction)prey1hunt:(id)sender {
    
    
}
- (IBAction)prey2hunt:(id)sender {
    
}

- (IBAction)prey3hunt:(id)sender {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
