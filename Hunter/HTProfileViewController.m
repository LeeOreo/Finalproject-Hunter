//
//  HTProfileViewController.m
//  Hunter
//
//  Created by 李育豪 on 2015/5/10.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import "HTProfileViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <PFFacebookUtils.h>

@interface HTProfileViewController ()

@end

@implementation HTProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    _backgroundImage.image = [UIImage imageNamed:@"backgrund2.jpg"];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    //set my photo
    NSString *myPhotoURLString = [[PFUser currentUser] objectForKey:@"pictureURL"];
    NSURL *myPhotoURL = [NSURL URLWithString:myPhotoURLString];
    NSData *myPhotoData = [NSData dataWithContentsOfURL:myPhotoURL];
    _myPhoto.image = [UIImage imageWithData:myPhotoData];
    
    [_myLevel setTitle:[[PFUser currentUser] objectForKey:@"RankLevel"]forState:(UIControlStateNormal)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
