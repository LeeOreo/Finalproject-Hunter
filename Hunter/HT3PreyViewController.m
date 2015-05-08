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
#import "SWRevealViewController.h"


@interface HT3PreyViewController ()


@end

@implementation HT3PreyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附近的獵物";
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    
    
    _backgroundImage.image = [UIImage imageNamed:@"phone.jpg"];
    
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
    
}

    //send preyInfo to mapVC
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"preyInfo1"]) {
        UINavigationController *navController = [segue destinationViewController];
        HTMapViewController *vc = navController.viewControllers[0];
        vc.preyDistance.text = self.preyDistanceOne.text;
    }else if ([[segue identifier] isEqualToString:@"preyInfo2"]){
        UINavigationController *navController = [segue destinationViewController];
        HTMapViewController *vc = navController.viewControllers[0];
        vc.preyDistance.text = self.preyDistanceTwo.text;
    }else if ([[segue identifier] isEqualToString:@"preyInfo3"]){
        UINavigationController *navController = [segue destinationViewController];
        HTMapViewController *vc = navController.viewControllers[0];
        vc.preyDistance.text = self.preyDistanceThree.text;

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
