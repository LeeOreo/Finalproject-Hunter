//
//  HTConst.h
//  Hunter
//
//  Created by 李育豪 on 2015/5/2.
//  Copyright (c) 2015年 ALPHACamp. All rights reserved.
//

#ifndef Hunter_HTConst_h
#define Hunter_HTConst_h

static double const UserDefaultFilterDistance = 1000.0;
static double const MaximumSearchDistance = 100.0; // Value in kilometers
static NSUInteger const HunterSearchDefaultLimit = 3; // Query limit for pins and tableviewcells

// Parse API key constants:
static NSString * const PAWParsePostsClassName = @"Posts";       //有不同種類的Post
static NSString * const PAWParsePostUserKey = @"user";
static NSString * const PAWParsePostUsernameKey = @"username";
static NSString * const PAWParsePostTextKey = @"text";
static NSString * const PAWParsePostLocationKey = @"location";   //
static NSString * const PAWParsePostNameKey = @"name";           //post's name

// NSNotification userInfo keys:
static NSString * const kPAWFilterDistanceKey = @"filterDistance";
static NSString * const kPAWLocationKey = @"location";

// NSUserDefaults
static NSString * const UserDefaultsFilterDistanceKey = @"filterDistance";

// Notification names:
static NSString * const UserCurrentLocationDidChangeNotification = @"UserCurrentLocationDidChangeNotification";

typedef double UserLocationAccuracy;

#endif
