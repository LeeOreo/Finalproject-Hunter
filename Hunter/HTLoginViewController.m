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

@interface HTLoginViewController ()

@end

@implementation HTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    array = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", nil];
    self.pageCtrl.numberOfPages = [array count];
    [self showImage];
}


//show the image
- (void) showImage {
    NSString *filename = [array objectAtIndex:self.pageCtrl.currentPage];
    self.teachImage.image = [UIImage imageNamed:filename];
}

- (IBAction)teachPageSwipe:(UISwipeGestureRecognizer *)sender {
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            //left
            if (self.pageCtrl.currentPage < [array count]) {
                self.pageCtrl.currentPage++;
                [self showImage];
            }
            break;
        case UISwipeGestureRecognizerDirectionRight:
            //right
            if (self.pageCtrl.currentPage > 0) {
                self.pageCtrl.currentPage--;
                [self showImage];
            }
            break;
        default:;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - FB data to Parse

- (IBAction)fbLoginButton:(id)sender {
    
    NSArray *permissionArray = @[@"user_about_me",@"user_relationships",@"user_location",@"user_friends",@"email"];
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
            NSString *email =userData[@"email"];
            NSString *pictureURL =[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID];
            NSLog(@"%@",pictureURL);
            [[PFUser currentUser] setObject:name forKey:@"name"];
            [[PFUser currentUser] setObject:facebookID forKey:@"facebookID"];
            [[PFUser currentUser] setObject:email forKey:@"email"];
            [[PFUser currentUser] setObject:pictureURL forKey:@"pictureURL"];
            
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
