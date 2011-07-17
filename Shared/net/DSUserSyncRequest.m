//
//  DSUserSyncRequest.m
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 Reality Box Labs, LLC. All rights reserved.
//

#import "DSUserSyncRequest.h"

#import "CJSONSerializer.h"
#import "CJSONDeserializer.h"

@interface DSUserSyncRequest()
@property (nonatomic, retain) NSString *baseURL;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *buffer;
@property (nonatomic, retain) NSHTTPURLResponse *response;
@end



@implementation DSUserSyncRequest

@synthesize baseURL = _baseURL;
@synthesize connection = _connection;
@synthesize buffer = _buffer;
@synthesize response = _response;


-(id) initWithBaseURL:(NSString*)baseURL withQueue:(dispatch_queue_t)queue
{
	if ((self = [super init]))
	{
		self.baseURL = baseURL;
		self.buffer = [NSMutableData data];
		_queue = queue;
	}
	return self;
}

-(void) dealloc
{
	self.response = nil;
	self.baseURL = nil;
	self.buffer = nil;
	
	[super dealloc];
}

-(void) start
{
	NSLog(@"Starting user sync from the network");
	[[NSNotificationCenter defaultCenter] postNotificationName:@"network.start" object:nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"usersync.start" object:nil];
	
	NSMutableURLRequest* req = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/users", _baseURL]]
												cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
											timeoutInterval:30.0];
	
	
	self.connection = [NSURLConnection connectionWithRequest:req delegate:self];
	// And we're off!
}

-(void) parseBuffer
{
	if (_response.statusCode != 200)
	{
		NSLog(@"User sync request failed with non-200 status code of %d", _response.statusCode);
		[[NSNotificationCenter defaultCenter] postNotificationName:@"usersync.failed" object:nil];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"network.stop" object:nil];
		return;
	}		
	
	
	NSError* error;
	id data = [[CJSONDeserializer deserializer] deserialize:_buffer error:&error];
	if (!data)
	{
		NSLog(@"ACK! User sync had trouble\n%@", error);
		[[NSNotificationCenter defaultCenter] postNotificationName:@"usersync.failed" object:nil];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"network.stop" object:nil];
		return;
	}
	
	NSLog(@"Um, got some data for users %@", data);
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"usersync.finished" object:nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"network.stop" object:nil];
}

////////// NSURLConnection delegate

//- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response;
//- (NSInputStream *)connection:(NSURLConnection *)connection needNewBodyStream:(NSURLRequest *)request NS_AVAILABLE(10_6, 3_0);
//- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace NS_AVAILABLE(10_6, 3_0);
//- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;
//- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;
//- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection NS_AVAILABLE(10_6, 3_0);
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response
{
	NSLog(@"user synch connection started: %d", response.statusCode);
	
	self.response = response;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[_buffer appendData:data];
}

//- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite NS_AVAILABLE(10_6, 3_0);
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"user sync did finish loading");
	
	dispatch_async(_queue, ^{
		[self parseBuffer];
	});
//	[[NSNotificationCenter defaultCenter] postNotificationName:@"usersync.finished" object:nil];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"user sync did fail with error %@", error);
	[[NSNotificationCenter defaultCenter] postNotificationName:@"usersync.failed" object:nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"network.stop" object:nil];
}

//- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse;

@end
