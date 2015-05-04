//
//  HTChoseViewController.m
//  Hunter
//
//  Created by 李育豪 on 2015/5/3.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import "HTChoseViewController.h"

@interface HTChoseViewController ()

@end

@implementation HTChoseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    //獵物大頭貼先用URL寫死
    NSURL *imageURL = [NSURL URLWithString:@"https://graph.facebook.com/481242102030491/picture?type=large&return_ssl_resources=1"];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    _prey1.image = [UIImage imageWithData:imageData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}


@end
