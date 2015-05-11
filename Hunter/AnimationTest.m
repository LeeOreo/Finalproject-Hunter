//
//  AnimationTest.m
//  Hunter
//
//  Created by 李育豪 on 2015/5/10.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import "AnimationTest.h"
#import "UIView+AnimationExtensions.h"
#import <AudioToolbox/AudioToolbox.h>

@interface AnimationTest ()

@property (assign, nonatomic) SystemSoundID threeAM;
void AudioServicesPlayAlertSound(SystemSoundID inSystemSoundID);

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
    
    NSURL *audioUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"ringtone.wav" ofType:nil]];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)audioUrl, &_threeAM);
    AudioServicesPlaySystemSound(self.threeAM);
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    
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
//
//}

//- (void)startAnimation {              //翻頁
//    [_boxView flipWithDuration:0.3f
//                     direction:UIViewAnimationFlipDirectionFromLeft
//                   repeatCount:25
//                   autoreverse:NO];
//
//}

//- (void)startAnimation {           //放大縮小
//    [_boxView pulseToSize:1.5f
//                 duration:0.3f
//                   repeat:YES];
//
//}

//- (void)startAnimation {             //水平震動
//    [_boxView shakeHorizontally];
//}

- (void)startAnimation {             //垂直震動
    [_boxView shakeVertically];
}


@end
