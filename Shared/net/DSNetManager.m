//
//  DSNetManager.m
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 Reality Box Labs LLC. All rights reserved.
//

#import "DSNetManager.h"
#import "DSUserSyncRequest.h"

#import "SynthesizeSingleton.h"

@interface DSNetManager()

@property (nonatomic, retain) DSUserSyncRequest *userSync;
@end


@implementation DSNetManager

@synthesize baseURL = _baseURL;
@synthesize userSync = _userSync;

SYNTHESIZE_SINGLETON_FOR_CLASS(DSNetManager)


-(id) init
{
	if ((self = [super init]))
	{
		self.baseURL = @"http://mins.microj.org/api";
		_netManQueue = dispatch_queue_create("net man", 0);
		
		// Let's do some sync stuff after the UI comes up
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rootVisible:) name:@"root.visible" object:nil];
	}
	return self;
}

-(void) dealloc
{
	self.baseURL = nil;
	
	[super dealloc];
}

-(void) startUserSync
{
	if (_userSync) return;
	
	self.userSync = [[[DSUserSyncRequest alloc] initWithBaseURL:_baseURL withQueue:_netManQueue] autorelease];
	[_userSync start];
}


-(void) startSync
{
	[self startUserSync];
	
}

-(void) rootVisible:(NSNotification*)notif
{
	if (_didStartupSync) return;
	_didStartupSync = YES;
	
	[self startSync];
}

@end
