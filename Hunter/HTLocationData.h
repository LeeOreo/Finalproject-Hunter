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

@property (strong, nonatomic) NSString *preyLevel1;
@property (strong, nonatomic) NSString *preyLevel2;
@property (strong, nonatomic) NSString *preyLevel3;

@property (strong, nonatomic) UIImage *preyPhoto1;
@property (strong, nonatomic) UIImage *preyPhoto2;
@property (strong, nonatomic) UIImage *preyPhoto3;

@property (strong, nonatomic) NSString *preyName1;
@property (strong, nonatomic) NSString *preyName2;
@property (strong, nonatomic) NSString *preyName3;

@property (strong, nonatomic) NSString *preyObjectID1;
@property (strong, nonatomic) NSString *preyObjectID2;
@property (strong, nonatomic) NSString *preyObjectID3;
 

+(HTLocationData *)sharePreyDistance;

- (NSArray *)getPreyData;

@end
