//
//  HTSufferAttackViewController.m
//  Hunter
//
//  Created by 李育豪 on 2015/5/14.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import "HTSufferAttackViewController.h"
#import "UIView+AnimationExtensions.h"
#import "HTLocationData.h"

@interface HTSufferAttackViewController ()

@end

@implementation HTSufferAttackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _sufferAttackImage.image = [UIImage imageNamed:@"yourunderatt.png"];

    HTLocationData *preyData = [HTLocationData sharePreyDistance];
    [preyData getPreyData];
    
    [_escapeDistance setTitle:preyData.preyDistance1 forState:(UIControlStateNormal)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
   
    seconds = 9;
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self
                                           selector:@selector(countDown)
                                           userInfo:nil
                                            repeats:YES];
    
    if ([_sufferAttackImage isBeingAnimated])
    {
        [_sufferAttackImage stopAnimation];
    }
    else
    {
        [self startAnimation];
    }
    
}

- (void)startAnimation {           //放大縮小
    [_sufferAttackImage pulseToSize:1.2f
                           duration:0.3f
                             repeat:YES];
}

- (void)countDown {
    seconds --;
    [_countDown setTitle:[NSString stringWithFormat:@"%i",seconds] forState:(UIControlStateNormal)];
    if (seconds == 0) {
        [timer invalidate];
        
        UIViewController *Result = [self.storyboard instantiateViewControllerWithIdentifier:@"Result"];
        [self presentViewController:Result animated:YES completion:nil];
    }
}

@end
