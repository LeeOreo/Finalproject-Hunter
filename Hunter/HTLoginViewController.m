//
//  HTLoginViewController.m
//  Hunter
//
//  Created by 李育豪 on 2015/4/28.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import "HTLoginViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <PFFacebookUtils.h>
#import "AppDelegate.h"

@interface HTLoginViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *teachScrollView;

@property (weak, nonatomic) IBOutlet UIImageView *teachImageView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation HTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    float width = (_teachImageView.frame.size.width);
    float height = (_teachImageView.frame.size.height);
    NSLog(@"with is : %f",width);
    self.teachScrollView.contentSize = CGSizeMake(width*3, height);
    
    NSArray *teachImageArray = [[NSArray alloc] initWithObjects:[UIImage imageNamed: @"TeachPage1.jpg"],[UIImage imageNamed:@"TeachPage2.jpg"],[UIImage imageNamed:@"TeachPage3.jpg"], nil];
    
    for (int i = 0; i<3; i++) {
        NSLog(@"yoyoyo");
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width*i, 0, width, height)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = teachImageArray[i];
        imageView.clipsToBounds = YES;
        [self.teachScrollView addSubview:imageView];
    }
}

//- (void) viewDidAppear:(BOOL)animated {
//    if ([PFUser currentUser]) {
//        
//        NSLog(@"testtesttesttesttest");
//        
//        UIViewController *slidemenuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"slidemenuVC"];
//        [self presentViewController:slidemenuVC animated:YES completion:nil];
//    }
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.teachImageView;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    self.pageControl.currentPage = page;
}



#pragma mark - FB data to Parse

- (IBAction)fbLoginButton:(id)sender {
    
    NSArray *permissionArray = @[@"email"];
    [PFFacebookUtils logInWithPermissions:permissionArray block:^(PFUser *user, NSError *error){
        if (!user) {
            NSString *errorMessage = nil;
            if (!error) {
                NSLog(@"Uh oh.The user cancelled the Facebook login.");
                errorMessage = @"";
            }else{
                NSLog(@"Uh oh. An error occurred: %@",error);
                errorMessage = [error localizedDescription];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log in Error"
                                                            message:errorMessage
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Dismiss", nil];
            [alert show];
        }else{
            if (user.isNew) {
                NSLog(@"User with facebook signed up and logged in!");
            }else{
                NSLog(@"User with facebook logged in!");
                
            }
            
            UIViewController *slidemenuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"slidemenuVC"];
            [self presentViewController:slidemenuVC animated:YES completion:nil];

            [self saveUserDataToParse];

        }
    }];
}

-(void) saveUserDataToParse
{
    FBRequest *request = [FBRequest requestForMe];
    
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        // handle response
        if (!error) {
            // Parse the data received
            NSDictionary *userData = (NSDictionary *)result;

            
            NSString *facebookID = userData[@"id"];
            NSString *name = userData[@"name"];
            NSString *pictureURL =[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID];
            NSString *email = userData[@"email"];
            
            NSLog(@"%@",pictureURL);
            [[PFUser currentUser] setObject:name forKey:@"name"];
            [[PFUser currentUser] setObject:facebookID forKey:@"facebookID"];
            [[PFUser currentUser] setObject:pictureURL forKey:@"pictureURL"];
            [[PFUser currentUser] setObject:email forKey:@"email"];

            
            [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
                if (!error) {
                    // do something with the new geoPoint
                }
            }];

            [[PFUser currentUser] saveInBackground];
            
        } else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
                    isEqualToString: @"OAuthException"]) { // Since the request failed, we can check if it was due to an invalid session
            NSLog(@"The facebook session was invalidated");
            
        } else {
            NSLog(@"Some other error: %@", error);
        }
    }];
}



@end
