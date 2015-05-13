//
//  HTMapViewController.h
//  Hunter
//
//  Created by 李育豪 on 2015/4/28.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

typedef NS_ENUM(NSUInteger, RAFDetailViewControllerMode)
{
    RAFDetailViewControllerMode_ShakeHorizontal,
    RAFDetailViewControllerMode_ShakeVertical,
    RAFDetailViewControllerMode_Pulse,
    RAFDetailViewControllerMode_MotionEffects,
    RAFDetailViewControllerMode_Rotate,
    RAFDetailViewControllerMode_Flip,
};

@interface HTMapViewController : UIViewController <MKMapViewDelegate>
{
    NSTimer *timer;
    int seconds;
}

@property (strong, nonatomic) IBOutlet MKMapView *myMap;

@property (strong, nonatomic) IBOutlet UIButton *preyDistance;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (strong, nonatomic) NSString *mode;

@property (strong, nonatomic) IBOutlet UIButton *timeLeft;


@end
