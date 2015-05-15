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
#import "HTRankViewCell.h"


@interface HTRankViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UIActivityIndicatorView *indicator;
    NSMutableArray *rankImageDataArray;
    NSMutableArray *rankLevelArray;
    NSMutableArray *rankPointArray;
}
@property (nonatomic, strong) NSMutableArray *rankingArray;

@end

@implementation HTRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    [self getRank];
//        indicator = [[UIActivityIndicatorView alloc]   initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        indicator.center = CGPointMake(160,200);
//         [self.view addSubview:indicator];
//        [indicator startAnimating];

}

- (void)getRank {
    indicator = [[UIActivityIndicatorView alloc]   initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.center = CGPointMake(160,200);
    [self.view addSubview:indicator];
    [indicator startAnimating];
    
    rankImageDataArray = [[NSMutableArray alloc] init];
    rankLevelArray = [[NSMutableArray alloc] init];
    rankPointArray = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFUser query];
    [query orderByDescending:@"RankPoint"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *array , NSError *error) {
        
        PFObject *object;
        for (object in array) {
            NSString *rankPhotoURL = [object objectForKey:@"pictureURL"];
            NSString *rankLevelName = [object objectForKey:@"RankLevel"];
            NSString *rankPoint = [object objectForKey:@"RankPoint"];
            
            
            NSURL *rankImageURL = [NSURL URLWithString:rankPhotoURL];
            NSData *rankImageData = [NSData dataWithContentsOfURL:rankImageURL];
            [rankImageDataArray addObject:rankImageData];
            [rankLevelArray addObject:rankLevelName];
            [rankPointArray addObject:rankPoint];
            
        }
        [self.rankingTable reloadData];
        [indicator stopAnimating];
    }];
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
    return rankImageDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HTRankViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTRankViewCell" forIndexPath:indexPath];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"排行榜框框.jpg"]];
    
    // Configure the cell...
   
    NSData *data = [rankImageDataArray objectAtIndex:indexPath.row];
    cell.rankPhoto.image = [UIImage imageWithData:data];
    
    NSString *rankLevelName = [rankLevelArray objectAtIndex:indexPath.row];
    rankLevelName = [NSString stringWithFormat:@"階級：%@",rankLevelName];
    cell.rankLevel.text = rankLevelName;
    
    NSString *rankingPoint = [rankPointArray objectAtIndex:indexPath.row];
    rankingPoint = [NSString stringWithFormat:@"得分：%@",rankingPoint];
    cell.rankPoint.text = rankingPoint;
    
    return cell;
}


@end
