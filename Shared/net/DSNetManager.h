//
//  DSNetManager.h
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 Reality Box Labs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DSUserSyncRequest;

@interface DSNetManager : NSObject {
	BOOL _didStartupSync;
	BOOL _syncStarted;

	NSString* _baseURL;
	
	
	dispatch_queue_t _netManQueue;
	DSUserSyncRequest* _userSync;
}

@property (nonatomic, retain) NSString *baseURL;

-(void) startSync;

+(DSNetManager*) sharedInstance;

@end
