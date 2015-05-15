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

    [NSTimer scheduledTimerWithTimeInterval:2
                                     target:self
                                   selector:@selector(checkStatus)
                                   userInfo:nil
                                    repeats:YES];
    
    _backgroundImage.image = [UIImage imageNamed:@"personaInfo#1.png"];
    _myPhoto.layer.cornerRadius = _myPhoto.frame.size.width/2;
    _myPhoto.layer.masksToBounds = YES;

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
    
    [_myPoint setTitle:[[[PFUser currentUser] objectForKey:@"RankPoint"] stringValue]forState:(UIControlStateNormal)];
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
