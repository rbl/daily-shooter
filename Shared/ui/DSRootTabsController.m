//
//  DSRootTabsController.m
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 Reality Box Labs, LLC. All rights reserved.
//

#import "DSRootTabsController.h"

#import "DSDataListChallenges.h"
#import "DSDataListUsers.h"


@interface DSRootTabsController()

@end




@implementation DSRootTabsController

@synthesize tabBar = _tabBar;
@synthesize dlChallenges = _dlChallenges;
@synthesize dlUsers = _dlUsers;

-(id) init
{
	if ((self = [super init]))
	{
//		self.dlChallenges = [[[DSDataListChallenges alloc] init] autorelease];
//		self.dlUsers = [[[DSDataListUsers alloc] init] autorelease];
//		
//		self.viewControllers = [NSArray arrayWithObjects:_dlChallenges, _dlUsers, nil];
		
		// TODO: Load previously selected tab from NSUserDefaults
	}
	return self;
}

-(void) dealloc
{
	self.tabBar = nil;
	self.dlChallenges = nil;
	self.dlUsers = nil;
	
	[super dealloc];
}


-(void) viewWillAppear:(BOOL)animated
{
	_tabBar.viewControllers = [NSArray arrayWithObjects:_dlChallenges, _dlUsers, nil];
	
	CGRect frame = self.view.bounds;
	UIView* navBar = [self.view.subviews objectAtIndex:0];
	CGRect navBarFrame = navBar.frame;
	
	frame.origin.y += navBarFrame.size.height;
	frame.size.height -= navBarFrame.size.height;
	_tabBar.view.frame = frame;
	_tabBar.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	[self.view addSubview:_tabBar.view];
}


-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	// It's always ok to rotate
	return YES;
}



@end
