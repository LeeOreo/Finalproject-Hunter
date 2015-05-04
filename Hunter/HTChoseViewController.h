//
//  HTChoseViewController.h
//  Hunter
//
//  Created by 李育豪 on 2015/5/3.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTChoseViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView *prey1;
@property (weak, nonatomic) IBOutlet UIImageView *prey2;
@property (weak, nonatomic) IBOutlet UIImageView *prey3;

@property (weak, nonatomic) IBOutlet UILabel *distance1;
@property (weak, nonatomic) IBOutlet UILabel *distance2;
@property (weak, nonatomic) IBOutlet UILabel *distance3;

@property (weak, nonatomic) IBOutlet UIButton *hunter1;
@property (weak, nonatomic) IBOutlet UIButton *hunter2;
@property (weak, nonatomic) IBOutlet UIButton *hunter3;


@end
