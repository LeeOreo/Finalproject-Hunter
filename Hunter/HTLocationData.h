//
//  HTLocationData.h
//  Hunter
//
//  Created by 李育豪 on 2015/5/6.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HTLocationData : NSObject

@property (strong, nonatomic) NSString *preyDistance1;
@property (strong, nonatomic) NSString *preyDistance2;
@property (strong, nonatomic) NSString *preyDistance3;

@property (strong, nonatomic) UIImage *preyPhoto1;
@property (strong, nonatomic) UIImage *preyPhoto2;
@property (strong, nonatomic) UIImage *preyPhoto3;

+(HTLocationData *)sharePreyDistance;

- (NSArray *)getPreyData;

@end
