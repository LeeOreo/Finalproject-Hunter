//
//  AnimationTest.h
//  Hunter
//
//  Created by 李育豪 on 2015/5/10.
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

@interface AnimationTest : UIViewController

@property(nonatomic, weak) IBOutlet UIImageView *boxView;


@end
