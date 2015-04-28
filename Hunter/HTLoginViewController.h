//
//  HTLoginViewController.h
//  Hunter
//
//  Created by 李育豪 on 2015/4/28.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTLoginViewController : UIViewController
{
    NSMutableArray *array;
}
@property (weak, nonatomic) IBOutlet UIImageView *teachImage;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrl;

- (void) showImage;

@end
