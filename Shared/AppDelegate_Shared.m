//
//  AppDelegate_Shared.m
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate_Shared.h"

#import "DSNetManager.h"
#import "DSDataStore.h"

@implementation AppDelegate_Shared

@synthesize window;



-(void)dealloc 
{    
    [window release];
    [super dealloc];
}

#pragma mark -
#pragma mark Application lifecycle

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{
	// Make sure the data stuff is ready now
	[DSNetManager sharedInstance];
	[DSDataStore sharedInstance];
	
	// Debugging
	// [[DSDataStore sharedInstance] generateSampleData];
	
	// A way for us to control the network activity indicator
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netStart:) name:@"network.start" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netStop:) name:@"network.stop" object:nil];

    return YES;
}

-(void)applicationWillTerminate:(UIApplication *)application 
{
}


-(void)applicationDidEnterBackground:(UIApplication *)application 
{
}    


#pragma mark -
#pragma mark Network Activity 

-(void) netStart:(NSNotification*)notif
{
	_pendingNetworkActivity++;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void) netStop:(NSNotification*)notif
{
	_pendingNetworkActivity--;
	if (_pendingNetworkActivity <= 0) 
	{
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	}	
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}




@end

