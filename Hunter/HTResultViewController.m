//
//  HTResultViewController.m
//  Hunter
//
//  Created by 李育豪 on 2015/5/14.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import "HTResultViewController.h"

@interface HTResultViewController ()

@end

@implementation HTResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goBackProfile:(id)sender {
    UIViewController *slidemenuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"slidemenuVC"];
    [self presentViewController:slidemenuVC animated:YES completion:nil];
}

@end
