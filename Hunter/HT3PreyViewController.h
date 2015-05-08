//
//  HT3PreyViewController.h
//  Hunter
//
//  Created by 李育豪 on 2015/5/6.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HT3PreyViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *preyDistanceOne;
@property (weak, nonatomic) IBOutlet UIImageView *preyImage1;

@property (weak, nonatomic) IBOutlet UILabel *preyDistanceTwo;
@property (weak, nonatomic) IBOutlet UIImageView *preyImage2;

@property (weak, nonatomic) IBOutlet UILabel *preyDistanceThree;
@property (weak, nonatomic) IBOutlet UIImageView *preyImage3;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
