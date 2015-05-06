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

//*********************************************************************************************
    
    //set prey distance~~~~~~~~~~~~~
    
    PFGeoPoint *myGeoPoint = [PFGeoPoint geoPointWithLatitude:appDel.userLocation.location.coordinate.latitude longitude:appDel.userLocation.location.coordinate.longitude];
    
   // PFObject *userlocation = [PFObject objectWithClassName:@"userLocation"];
   // userlocation[@"userLocation"] = myGeoPoint;
    
//    NSMutableArray *preyArray = [[NSMutableArray alloc] init];

    // User's location
//    PFGeoPoint *myGeoPoint = userObject[@"userLocation"];
    // Create a query for places
    PFQuery *query = [PFUser query];
    // Interested in locations near user.
    [query whereKey:@"userLocation" nearGeoPoint:myGeoPoint];
    // Limit what could be a lot of points.
    query.limit = 4;
    // Final list of objects
//    [preyArray addObject:[query findObjects]];
    
    NSArray *array = [query findObjects];
    NSLog(@"array %d",array.count);
    
    
//    PFQuery *query2 = [PFUser query];
//    [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        
//        NSLog(@"aaaa %@,%@",objects,error);
//        
//    }];


    
    NSMutableArray *preyArray = [[NSMutableArray alloc] initWithArray:[query findObjects]];

    NSLog(@"sesese%@",preyArray);

    PFGeoPoint *preylocation = [preyArray[3] objectForKey:@"userLocation"];
    NSLog(@"jijijijijijjijijijijiji%@",preylocation);
//    CLLocationDistance distance = [myGeoPoint distanceFromLocation:preylocation];
    
    
//    CLLocationDistance distance = [userGeoPoint distanceFromLocation:];
//    NSLog(@"distance is : %f",distance);
    
//***********************************************************************************************
    //assure user location is right
    NSLog(@"現在經緯 : %f,%f",appDel.userLocation.location.coordinate.latitude,appDel.userLocation.location.coordinate.longitude);
    
    
    self.circleOverlay = [MKCircle circleWithCenterCoordinate:appDel.userLocation.location.coordinate radius:100];
    [_myMap addOverlay:self.circleOverlay];
    
    
    
//    CLLocationAccuracy filterDistance = [[NSUserDefaults standardUserDefaults] doubleForKey:UserDefaultsFilterDistanceKey];

}

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

- (void)viewDidAppear:(BOOL)animated {
    AppDelegate* appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.myMap.centerCoordinate = CLLocationCoordinate2DMake(appDel.userLocation.location.coordinate.latitude,appDel.userLocation.location.coordinate.longitude);
}

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
