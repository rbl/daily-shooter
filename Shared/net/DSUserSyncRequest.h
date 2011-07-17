//
//  DSUserSyncRequest.h
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 Reality Box Labs, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DSUserSyncRequest : NSObject  {
	
	NSString* _baseURL;
	NSURLConnection* _connection;
	NSHTTPURLResponse* _response;

	NSMutableData* _buffer;
	dispatch_queue_t _queue;
}

-(id) initWithBaseURL:(NSString*)baseURL withQueue:(dispatch_queue_t)queue;
-(void) start;

@end
