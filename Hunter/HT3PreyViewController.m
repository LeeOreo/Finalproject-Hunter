//
//  HT3PreyViewController.m
//  Hunter
//
//  Created by 李育豪 on 2015/5/6.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import "HT3PreyViewController.h"
#import <Parse/Parse.h>
#import "HTMapViewController.h"
#import "HTLocationData.h"
#import "SWRevealViewController.h"

@interface HT3PreyViewController ()
{
    UIActivityIndicatorView *indicator;
}
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
//    indicator = [[UIActivityIndicatorView alloc]   initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    indicator.center = CGPointMake(160,200);
//    [self.view addSubview:indicator];
//    [indicator startAnimating];

    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(updateView)
                                   userInfo:nil
                                    repeats:YES];
    
 
//    [indicator stopAnimating];
    
    //******************************************************************************

}

- (void)updateView {
    
    indicator = [[UIActivityIndicatorView alloc]   initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.center = CGPointMake(160,200);
    [self.view addSubview:indicator];
    [indicator startAnimating];
    
    _backgroundImage.image = [UIImage imageNamed:@"修改選人#1.png"];
    
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
    
    [indicator stopAnimating];

    
}
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

@end
