//
//  DSImageGridController.m
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 Reality Box Labs, LLC. All rights reserved.
//

#import "DSImageGridController.h"


@interface DSImageGridController()

//-(void) orientationChanged:(NSNotification*)notif;

@end




@implementation DSImageGridController

@synthesize popoverDelegate = _popoverDelegate;
@synthesize navBar = _navBar;
@synthesize navItem = _navItem;
@synthesize collectionsButtonItem = _collectionsButtonItem;


-(void)dealloc 
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
	
	// Not strictly necessary since it's an assigned delegate, but ok
	self.popoverDelegate = nil;

	self.navBar = nil;
	self.navItem = nil;
	self.collectionsButtonItem = nil;
    [super dealloc];
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
-(void)viewDidLoad 
{
    [super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated
{
//	[self orientationChanged:nil];
}


-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	// It's always ok to rotate
	return YES;
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	// Set the presence of the bar button item properly
	if (_popoverDelegate) 
	{
		[_popoverDelegate hidePopover];
		if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
			// Wish to remove the bar button
			_navItem.leftBarButtonItem = nil;
		}
		else
		{
			_navItem.leftBarButtonItem = _collectionsButtonItem;
		}
	}
	else
	{
		_navItem.leftBarButtonItem = nil;
	}
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}





-(IBAction) colAction:(id)sender
{
	if (_popoverDelegate)
	{
		[_popoverDelegate showPopover:sender];
	}
}

@end
