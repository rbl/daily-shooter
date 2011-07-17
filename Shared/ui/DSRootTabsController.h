//
//  DSRootTabsController.h
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 Reality Box Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DSDataListChallenges;
@class DSDataListUsers;

@interface DSRootTabsController : UIViewController {
	UITabBarController* _tabBar;
	DSDataListChallenges* _dlChallenges;
	DSDataListUsers* _dlUsers;
}

@property (nonatomic, retain) IBOutlet UITabBarController *tabBar;
@property (nonatomic, retain) IBOutlet DSDataListChallenges *dlChallenges;
@property (nonatomic, retain) IBOutlet DSDataListUsers *dlUsers;

@end
