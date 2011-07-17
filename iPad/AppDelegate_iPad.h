//
//  AppDelegate_iPad.h
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate_Shared.h"

@class DSPadRootViewController;
@class DSPadSplitController;

@interface AppDelegate_iPad : AppDelegate_Shared 
{	
	DSPadSplitController* _splitController;
}

@property (nonatomic, retain) IBOutlet DSPadSplitController *splitController;

@end

