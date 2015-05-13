//
//  HT3PreyViewController.h
//  Hunter
//
//  Created by 李育豪 on 2015/5/6.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HT3PreyViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIButton *preyDistanceOne;
@property (weak, nonatomic) IBOutlet UIImageView *preyImage1;
@property (strong, nonatomic) IBOutlet UIButton *preyButton1;

@property (strong, nonatomic) IBOutlet UIButton *preyDistanceTwo;
@property (weak, nonatomic) IBOutlet UIImageView *preyImage2;
@property (strong, nonatomic) IBOutlet UIButton *preyButton2;

@property (strong, nonatomic) IBOutlet UIButton *preyDistanceThree;
@property (weak, nonatomic) IBOutlet UIImageView *preyImage3;
@property (strong, nonatomic) IBOutlet UIButton *preyButton3;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
