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
#import "HTMapViewController.h"
#import "HTLocationData.h"

@interface HT3PreyViewController ()


@end

@implementation HT3PreyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    HTLocationData *locationData = [[HTLocationData alloc] init];
//    NSArray *preyArray = [locationData getPreyData];
    
    _backgroundImage.image = [UIImage imageNamed:@"phone.jpg"];
    
//    //set prey1 photo~~~~~~~~~~~
//    NSString *preyImageURL1 = [preyArray[1] objectForKey:@"pictureURL"];
//    NSURL *imageURL1 = [NSURL URLWithString:preyImageURL1];
//    NSData *imageData1 = [NSData dataWithContentsOfURL:imageURL1];
//    _preyImage1.image = [UIImage imageWithData:imageData1];
//    
//    //set prey2 photo~~~~~~~~~~~
//    NSString *preyImageURL2 = [preyArray[2] objectForKey:@"pictureURL"];
//    NSURL *imageURL2 = [NSURL URLWithString:preyImageURL2];
//    NSData *imageData2 = [NSData dataWithContentsOfURL:imageURL2];
//    _preyImage2.image = [UIImage imageWithData:imageData2];
//    
//    //set prey3 photo~~~~~~~~~~~
//    NSString *preyImageURL3 = [preyArray[3] objectForKey:@"pictureURL"];
//    NSURL *imageURL3 = [NSURL URLWithString:preyImageURL3];
//    NSData *imageData3 = [NSData dataWithContentsOfURL:imageURL3];
//    _preyImage3.image = [UIImage imageWithData:imageData3];
//    
//    
//    MKPointAnnotation *point;
//    
//    //透過UIApplication sharedApplication 設定 Global 變數
//    AppDelegate* appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    point.coordinate = CLLocationCoordinate2DMake(appDel.userLocation.location.coordinate.latitude,appDel.userLocation.location.coordinate.longitude);
    
    
//******************************************************************************************
    
    HTLocationData *preyData = [HTLocationData sharePreyDistance];
    [preyData getPreyData];
    
    _preyImage1.image = preyData.preyPhoto1;
    _preyImage2.image = preyData.preyPhoto2;
    _preyImage3.image = preyData.preyPhoto3;
    
    _preyDistanceOne.text = preyData.preyDistance1;
    _preyDistanceTwo.text = preyData.preyDistance2;
    _preyDistanceThree.text = preyData.preyDistance3;
    

    
    NSLog(@"Global var is : %@",preyData.preyDistance1);

    
    
    
    
//    //set prey1 distance
//    
//    PFGeoPoint *tempLocation1 = [preyArray[1] objectForKey:@"userLocation"];
//    
//    CLLocation *preylocation1 = [[CLLocation alloc]initWithLatitude:tempLocation1.latitude longitude:tempLocation1.longitude];
//
//    double distance1 = [appDel.userLocation.location distanceFromLocation:preylocation1];
//    NSLog(@"distance is : %02f",distance1);
//    
//    _preyDistance1.text = [NSString stringWithFormat:@"%1f",distance1];
//    
//    
//    //set prey2 distance
//    
//    PFGeoPoint *tempLocation2 = [preyArray[2] objectForKey:@"userLocation"];
//    
//    CLLocation *preylocation2 = [[CLLocation alloc]initWithLatitude:tempLocation2.latitude longitude:tempLocation2.longitude];
//    
//    double distance2 = [appDel.userLocation.location distanceFromLocation:preylocation2];
//    NSLog(@"distance is : %02f",distance2);
//    
//    _preyDistance2.text = [NSString stringWithFormat:@"%1f",distance2];
//    
//    //set prey3 distance
//    
//    PFGeoPoint *tempLocation3 = [preyArray[3] objectForKey:@"userLocation"];
//    
//    CLLocation *preylocation3 = [[CLLocation alloc]initWithLatitude:tempLocation3.latitude longitude:tempLocation3.longitude];
//    
//    double distance3 = [appDel.userLocation.location distanceFromLocation:preylocation3];
//    NSLog(@"distance is : %02f",distance3);
//    
//    _preyDistance3.text = [NSString stringWithFormat:@"%1f",distance3];
    
}

    //send preyInfo to mapVC
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"preyInfo1"]) {
        UINavigationController *navController = [segue destinationViewController];
        HTMapViewController *vc = navController.viewControllers[0];
//        vc.preyDistance.text = self.preyDistance1.text;
        
    }else if ([[segue identifier] isEqualToString:@"preyInfo2"]) {
        HTMapViewController *vc = [segue destinationViewController];
        
    }else if ([[segue identifier] isEqualToString:@"preyInfo3"]) {
        HTMapViewController *vc = [segue destinationViewController];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
