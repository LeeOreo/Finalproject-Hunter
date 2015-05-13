//
//  HT3PreyViewController.m
//  Hunter
//
//  Created by 李育豪 on 2015/5/6.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import "HT3PreyViewController.h"
//#import "AppDelegate.h"
#import <Parse/Parse.h>
//#import <ParseFacebookUtils/PFFacebookUtils.h>
//#import <CoreLocation/CoreLocation.h>
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
    
    _backgroundImage.image = [UIImage imageNamed:@"修改選人#1.png"];
    
//    _preyDistanceOne.contentMode = UIViewContentModeScaleAspectFit;
//    _preyDistanceOne.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"距離.png"]];
    
    //**************************************************************************************
    
    HTLocationData *preyData = [HTLocationData sharePreyDistance];
    [preyData getPreyData];
    
    _preyImage1.layer.cornerRadius = _preyImage1.frame.size.width/2;
    _preyImage1.layer.masksToBounds = YES;
    
    _preyImage2.layer.cornerRadius = _preyImage2.frame.size.width/2;;
    _preyImage2.layer.masksToBounds = YES;

    _preyImage3.layer.cornerRadius = _preyImage3.frame.size.width/2;;
    _preyImage3.layer.masksToBounds = YES;

    
    _preyImage1.image = preyData.preyPhoto1;
    _preyImage2.image = preyData.preyPhoto2;
    _preyImage3.image = preyData.preyPhoto3;
    
    [_preyDistanceOne setTitle:preyData.preyDistance1 forState:(UIControlStateNormal)];
    [_preyDistanceTwo setTitle:preyData.preyDistance2 forState:(UIControlStateNormal)];
    [_preyDistanceThree setTitle:preyData.preyDistance3 forState:(UIControlStateNormal)];
}

//******************************************************************************************


    //send preyInfo to mapVC
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"preyInfo1"]) {
        UINavigationController *navController = [segue destinationViewController];
        HTMapViewController *vc = navController.viewControllers[0];
        vc.mode = @"1";
    }else if ([[segue identifier] isEqualToString:@"preyInfo2"]){
        UINavigationController *navController = [segue destinationViewController];
        HTMapViewController *vc = navController.viewControllers[0];
        vc.mode = @"2";
    }else if ([[segue identifier] isEqualToString:@"preyInfo3"]){
        UINavigationController *navController = [segue destinationViewController];
        HTMapViewController *vc = navController.viewControllers[0];
        vc.mode = @"3";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
