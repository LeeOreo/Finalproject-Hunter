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
//#import "HTConst.h"
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
//#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "HTLocationData.h"
#import "HT3PreyViewController.h"
#import "UIView+AnimationExtensions.h"


@interface HTMapViewController ()  <MKMapViewDelegate>

@property (nonatomic, strong) MKCircle *circleOverlay;

@end

@implementation HTMapViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    _backgroundImage.image = [UIImage imageNamed:@"backgrund2.jpg"];

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
    
    
    HTLocationData *preyData = [HTLocationData sharePreyDistance];
    [preyData getPreyData];

    if (([_mode isEqualToString: @"1"])) {
        [_preyDistance setTitle:preyData.preyDistance1 forState:(UIControlStateNormal)];
    }else if (([self.mode isEqualToString: @"2"])){
        [_preyDistance setTitle:preyData.preyDistance2 forState:(UIControlStateNormal)];
    }else if (([_mode isEqualToString: @"3"])){
        [_preyDistance setTitle:preyData.preyDistance3 forState:(UIControlStateNormal)];
    }
}

    //set attack distance
- (MKOverlayRenderer *)mapView:(MKMapView *)hmapView rendererForOverlay:(id < MKOverlay >)overlay {
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


- (IBAction)attack:(id)sender {
    if ([_backgroundImage isBeingAnimated])
    {
        [_backgroundImage stopAnimation];
    }
    else
    {
        [self startAnimation];
    }
    
    seconds = 15;
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self
                                           selector:@selector(countDown)
                                           userInfo:nil
                                            repeats:YES];
    
    
//    PFACL *roleACL = [PFACL ACL];
//    [roleACL setPublicReadAccess:YES];
//    PFRole *role = [PFRole roleWithName:@"Administrator" acl:roleACL];
//    [role saveInBackground];
//    
//    
//    
//    HTLocationData *preyData = [HTLocationData sharePreyDistance];
//    [preyData getPreyData];
//    
////    [user setObject: userGeoPoint forKey: @"userLocation"];
//    preyData.checkAttack1 = YES;
//    
//    [[PFUser currentUser] saveInBackground];
}

- (void)startAnimation {           //放大縮小
    [_backgroundImage pulseToSize:1.2f
                         duration:0.3f
                           repeat:YES];
    
}
- (void)countDown {
    seconds --;
    [_timeLeft setTitle:[NSString stringWithFormat:@"%i",seconds] forState:(UIControlStateNormal)];
    if (seconds == 0) {
        [timer invalidate];
        UIViewController *AnimationTest = [self.storyboard instantiateViewControllerWithIdentifier:@"AnimationTest"];
        [self presentViewController:AnimationTest animated:YES completion:nil];
    }
}

- (void)sufferAttack {
    if ([[PFUser currentUser] objectForKey:@"Attack"]) {
        NSLog(@"Alert!Alert!");
    }
}


//********************************************************************************************


@end
