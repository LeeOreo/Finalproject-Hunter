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

    
    self.circleOverlay = [MKCircle circleWithCenterCoordinate:appDel.userLocation.location.coordinate radius:100];
    [_myMap addOverlay:self.circleOverlay];
    
}

    //set attack distance
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay {
    if ([overlay isKindOfClass:[MKCircle class]]) {
        MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithCircle:self.circleOverlay];
        [circleRenderer setFillColor:[[UIColor redColor] colorWithAlphaComponent:0.2f]];
        [circleRenderer setStrokeColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.7f]];
        [circleRenderer setLineWidth:1.0f];
        return circleRenderer;
    }
    return nil;
}

//- (void)viewDidAppear:(BOOL)animated {
//    AppDelegate* appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    self.myMap.centerCoordinate = CLLocationCoordinate2DMake(appDel.userLocation.location.coordinate.latitude,appDel.userLocation.location.coordinate.longitude);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//********************************************************************************************

//- (IBAction)whenSufferAttack:(id)sender {
//    
//    UIAlertController *attackAlert = [UIAlertController alertControllerWithTitle:@"危險危險"
//                                                                         message:@"快逃快逃"
//                                                                  preferredStyle:UIAlertControllerStyleAlert];
//    //declare LEFT
//    UIAlertAction *leftAction = [UIAlertAction actionWithTitle:@"往左逃"
//                                                         style:UIAlertActionStyleDefault
//                                                       handler:^(UIAlertAction *action) {
//        
//    }]
//    
//}

@end
