//
//  HTCountDownViewController.h
//  Hunter
//
//  Created by 李育豪 on 2015/5/5.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTCountDownViewController : UIViewController

{
    NSTimer *timer;
    int seconds;
}
@property (weak, nonatomic) IBOutlet UILabel *secondLeft;


@end
