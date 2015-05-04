//
//  HTMapViewController.m
//  Hunter
//
//  Created by 李育豪 on 2015/4/28.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import "HTMapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "HTConst.h"
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface HTMapViewController ()  <MKMapViewDelegate>

@property (nonatomic, strong) MKCircle *circleOverlay;

@end

@implementation HTMapViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    MKPointAnnotation *point;
    
    //透過UIApplication sharedApplication 設定 Global 變數
    AppDelegate* appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    point.coordinate = CLLocationCoordinate2DMake(appDel.userLocation.location.coordinate.latitude,appDel.userLocation.location.coordinate.longitude);
    
    //設定初始地圖大小
    [self.myMap setRegion:MKCoordinateRegionMake(appDel.userLocation.location.coordinate, MKCoordinateSpanMake(0.003f, 0.003f)) animated:YES];
    [self.myMap setShowsUserLocation:YES];
    [self.myMap setDelegate:self];

    
    //set prey photo~~~~~~~~~~~
    NSURL *imageURL = [NSURL URLWithString:@"https://graph.facebook.com/481242102030491/picture?type=large&return_ssl_resources=1"];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    _preyImage.image = [UIImage imageWithData:imageData];

    
    //set prey distance~~~~~~~~~~~~~
    
//    CLLocationDistance distance = [startLocation distanceFromLocation:endLocation]; // aka double
//    _preyDistance = distance;
    
    //assure user location is right
    NSLog(@"現在經緯 : %f,%f",appDel.userLocation.location.coordinate.latitude,appDel.userLocation.location.coordinate.longitude);
    
    
    

    self.circleOverlay = [MKCircle circleWithCenterCoordinate:appDel.userLocation.location.coordinate radius:UserDefaultFilterDistance];
    [_myMap addOverlay:self.circleOverlay];
    
    
    
    
    
    
//    CLLocationAccuracy filterDistance = [[NSUserDefaults standardUserDefaults] doubleForKey:UserDefaultsFilterDistanceKey];

}



- (void)viewDidAppear:(BOOL)animated {
    AppDelegate* appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.myMap.centerCoordinate = CLLocationCoordinate2DMake(appDel.userLocation.location.coordinate.latitude,appDel.userLocation.location.coordinate.longitude);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
