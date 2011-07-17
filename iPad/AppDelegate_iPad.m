//
//  AppDelegate_iPad.m
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate_iPad.h"
#import "DSPadSplitController.h"

@implementation AppDelegate_iPad

@synthesize splitController = _splitController;

-(void)dealloc 
{
	self.splitController = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Application lifecycle

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
    
	if (![super application:application didFinishLaunchingWithOptions:launchOptions]) return NO;

	// Get the UI up and running
	//self.rootController = [[[DSPadRootViewController alloc] init] autorelease];
	//[self.window addSubview:_rootController.view];
	
	self.splitController = [[[DSPadSplitController alloc] init] autorelease];
	//[self.window addSubview:_splitController.view];
	[self.window setRootViewController:_splitController];
	
    [self.window makeKeyAndVisible];
    
    return YES;
}


-(void)applicationWillResignActive:(UIApplication *)application 
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


-(void)applicationDidBecomeActive:(UIApplication *)application 
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


/**
 Superclass implementation saves changes in the application's managed object context before the application terminates.
 */
-(void)applicationWillTerminate:(UIApplication *)application 
{
	[super applicationWillTerminate:application];
}


#pragma mark -
#pragma mark Memory management

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application 
{
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
    [super applicationDidReceiveMemoryWarning:application];
}




@end

