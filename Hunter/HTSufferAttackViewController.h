//
//  HTSufferAttackViewController.h
//  Hunter
//
//  Created by 李育豪 on 2015/5/14.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RAFDetailViewControllerMode)
{
    RAFDetailViewControllerMode_ShakeHorizontal,
    RAFDetailViewControllerMode_ShakeVertical,
    RAFDetailViewControllerMode_Pulse,
    RAFDetailViewControllerMode_MotionEffects,
    RAFDetailViewControllerMode_Rotate,
    RAFDetailViewControllerMode_Flip,
};


@interface HTSufferAttackViewController : UIViewController
{
    NSTimer *timer;
    int seconds;
}
@property(nonatomic, weak) IBOutlet UIImageView *sufferAttackImage;

@property (strong, nonatomic) IBOutlet UIButton *countDown;

@property (strong, nonatomic) IBOutlet UIButton *escapeDistance;

@end
