//
//  HTCountDownViewController.m
//  Hunter
//
//  Created by 李育豪 on 2015/5/5.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import "HTCountDownViewController.h"

@interface HTCountDownViewController ()

@end

@implementation HTCountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startCountDown:(id)sender {
    seconds = 10;
    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self
                                           selector:@selector(countDown)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)countDown {
    seconds --;
    _secondLeft.text = [NSString stringWithFormat:@"%i",seconds];
    if (seconds == 0) {
        [timer invalidate];
    }
    
}

@end
