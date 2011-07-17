//
//  DSPadSplitController.h
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 Reality Box Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DSImageGridController.h"

@class DSRootTabsController;
@class DSImageGridController;

@interface DSPadSplitController : UISplitViewController <DSImageGridPopoverDelegate>
{
	DSRootTabsController* _tabs;
	DSImageGridController* _imageGrid;
	
	UIPopoverController* _popover;
}

@property (nonatomic, retain) IBOutlet DSRootTabsController *tabs;
@property (nonatomic, retain) IBOutlet DSImageGridController *imageGrid;

@end
