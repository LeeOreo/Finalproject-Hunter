//
//  HTRankViewController.m
//  Hunter
//
//  Created by 李育豪 on 2015/5/9.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import "HTRankViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <PFFacebookUtils.h>
#import "HTRankViewCell.h"


@interface HTRankViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *rankingArray;


@end

@implementation HTRankViewController

- (void)awakeFromNib {
    
    _rankingArray = [[NSMutableArray alloc] init];
    PFQuery *query = [PFUser query];
    [query orderByDescending:@"RankPoint"];
    _rankingArray = (NSMutableArray *)[query findObjects];
    
    NSLog(@"%@",_rankingArray);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rankingArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HTRankViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTRankViewCell" forIndexPath:indexPath];
    
    
    // Configure the cell...
    NSString *rankPhotoURL =[[_rankingArray objectAtIndex:indexPath.row] objectForKey:@"pictureURL"];
    NSURL *rankImageURL = [NSURL URLWithString:rankPhotoURL];
    NSData *rankImageData = [NSData dataWithContentsOfURL:rankImageURL];
    cell.rankPhoto.image = [UIImage imageWithData:rankImageData];
    
    
    NSString *rankLevelName = [[_rankingArray objectAtIndex:indexPath.row] objectForKey:@"RankLevel"];
    rankLevelName = [NSString stringWithFormat:@"階級：%@",rankLevelName];
    cell.rankLevel.text = rankLevelName;
    
    
    NSString *rankingPoint = [[_rankingArray objectAtIndex:indexPath.row] objectForKey:@"RankPoint"];
    rankingPoint = [NSString stringWithFormat:@"得分：%@",rankingPoint];
    cell.rankPoint.text = rankingPoint;
    
    return cell;
}


@end
