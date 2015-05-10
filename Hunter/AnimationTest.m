//
//  AnimationTest.m
//  Hunter
//
//  Created by 李育豪 on 2015/5/10.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import "AnimationTest.h"
#import "UIView+AnimationExtensions.h"

@interface AnimationTest ()

@end

@implementation AnimationTest

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _boxView.image = [UIImage imageNamed:@"TeachPage3.jpg"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTapped:(id)sender
{
    if ([_boxView isBeingAnimated])
    {
        [_boxView stopAnimation];
    }
    else
    {
        [self startAnimation];
    }
}

//- (void)startAnimation {             //旋轉
//    [_boxView rotateToAngle:M_PI * 2.0f
//                   duration:1.0f
//                  direction:UIViewAnimationRotationDirectionLeft
//                repeatCount:2
//                autoreverse:YES];
//

//}
//- (void)startAnimation {              //翻頁
//    [_boxView flipWithDuration:0.3f
//                     direction:UIViewAnimationFlipDirectionFromLeft
//                   repeatCount:2
//                   autoreverse:NO];
//
//}

- (void)startAnimation {           //放大縮小
    [_boxView pulseToSize:1.5f
                 duration:0.3f
                   repeat:YES];

}

//- (void)startAnimation {             //水平震動
//    [_boxView shakeHorizontally];
//}



@end
