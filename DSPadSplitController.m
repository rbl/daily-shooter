//
//  DSPadSplitController.m
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 Reality Box Labs, LLC. All rights reserved.
//

#import "DSPadSplitController.h"

#import "DSRootTabsController.h"
#import "DSImageGridController.h"

@interface DSPadSplitController()

@property (nonatomic, retain) UIPopoverController *popover;

@end



@implementation DSPadSplitController

@synthesize tabs = _tabs;
@synthesize imageGrid = _imageGrid;
@synthesize popover = _popover;

-(id) init
{
	if ((self = [super init]))
	{
		self.tabs = [[[DSRootTabsController alloc] init] autorelease];
		self.imageGrid = [[[DSImageGridController alloc] init] autorelease];
		_imageGrid.popoverDelegate = self;
		
		self.viewControllers = [NSArray arrayWithObjects:_tabs, _imageGrid, nil];
	}
	return self;
}

-(void)dealloc 
{
	self.tabs = nil;
	self.imageGrid = nil;
	
    [super dealloc];
}


-(void) viewDidAppear:(BOOL)animated 
{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"root.visible" object:nil];
	
	
}

#pragma mark DSImageGridPopoverDelegate

-(void) showPopover:(UIBarButtonItem*)item
{
	self.popover = [[[UIPopoverController alloc] initWithContentViewController:_tabs] autorelease];
	
	[_popover presentPopoverFromBarButtonItem:item permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void) hidePopover
{
	[_popover dismissPopoverAnimated:NO];
	self.popover = nil;
}

@end
