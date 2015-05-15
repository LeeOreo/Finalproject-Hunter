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
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import "HTLocationData.h"
#import "HT3PreyViewController.h"
#import "UIView+AnimationExtensions.h"


@interface HTMapViewController ()  <MKMapViewDelegate>

@property (nonatomic, strong) MKCircle *circleOverlay;

@end

@implementation HTMapViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    [NSTimer scheduledTimerWithTimeInterval:2
                                     target:self
                                   selector:@selector(checkStatus)
                                   userInfo:nil
                                    repeats:YES];
    

    _backgroundImage.image = [UIImage imageNamed:@"攻擊頁面#1.png"];

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
    
    seconds = 5;
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self
                                           selector:@selector(countDown)
                                           userInfo:nil
                                            repeats:YES];
    
    HTLocationData *preyData = [HTLocationData sharePreyDistance];
    [preyData getPreyData];
    
    if (([_mode isEqualToString: @"1"])) {
        PFObject *event = [PFObject objectWithClassName:@"Event"];
        event[@"Action"] = @"SufferAttack";
        event[@"preyName"] = preyData.preyName1;
        event[@"tartgetPointer"] = preyData.preyObjectID1;

        [event saveInBackground];
    }else if (([self.mode isEqualToString: @"2"])){
        PFObject *event = [PFObject objectWithClassName:@"Event"];
        event[@"Action"] = @"SufferAttack";
        event[@"preyName"] = preyData.preyName2;
        event[@"tartgetPointer"] = preyData.preyObjectID2;

        [event saveInBackground];
    }else if (([_mode isEqualToString: @"3"])){
        PFObject *event = [PFObject objectWithClassName:@"Event"];
        event[@"Action"] = @"SufferAttack";
        event[@"preyName"] = preyData.preyName3;
        event[@"tartgetPointer"] = preyData.preyObjectID3;
        
        [event saveInBackground];
    }

}

- (void)checkStatus {
    
    PFUser *user = [PFUser currentUser];
    PFQuery *statusQuery = [PFQuery queryWithClassName:@"Event"];   //query event這個class
    [statusQuery includeKey:@"tartgetPointer"];                      //做一個key準備接
    [statusQuery whereKey:@"tartgetPointer" equalTo:user];           //綁定PFUser
    [statusQuery whereKey:@"Action" equalTo:@"SufferAttack"];       //確認是否遭受Attack
    [statusQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count > 0) {
            //change viewcontroller when attack
            
            UIViewController *SufferAttack = [self.storyboard instantiateViewControllerWithIdentifier:@"SufferAttack"];
            [self presentViewController:SufferAttack animated:YES completion:nil];
        }else
            NSLog(@"eeeeeeeeee");
    }];
    
}

- (void)startAnimation {             //水平震動
    [_backgroundImage shakeHorizontally];
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



@end
