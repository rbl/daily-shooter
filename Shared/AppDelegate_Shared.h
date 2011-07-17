//
//  AppDelegate_Shared.h
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate_Shared : NSObject <UIApplicationDelegate> 
{
	int _pendingNetworkActivity;
	
    UIWindow *window;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

