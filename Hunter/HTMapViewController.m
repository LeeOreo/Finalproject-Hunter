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

@interface HTMapViewController ()
{
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}
@end

@implementation HTMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    MKPointAnnotation *point;
    
    AppDelegate* appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    point.coordinate = CLLocationCoordinate2DMake(appDel.userLocation.location.coordinate.latitude,appDel.userLocation.location.coordinate.longitude);
    NSLog(@"%f,%f",appDel.userLocation.location.coordinate.latitude,appDel.userLocation.location.coordinate.longitude);

    point.title = @"目前位置";
    [self.myMap addAnnotation:point];
     

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
