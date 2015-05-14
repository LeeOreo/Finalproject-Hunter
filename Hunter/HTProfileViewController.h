//
//  HTProfileViewController.h
//  Hunter
//
//  Created by 李育豪 on 2015/5/10.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) IBOutlet UIImageView *myPhoto;

@property (strong, nonatomic) IBOutlet UIButton *myLevel;

@property (strong, nonatomic) IBOutlet UIButton *myPoint;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@end
