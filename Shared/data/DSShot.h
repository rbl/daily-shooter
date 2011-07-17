//
//  DSShot.h
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class DSChallenge;

@interface DSShot :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * hostingID;
@property (nonatomic, retain) NSString * tweetID;
@property (nonatomic, retain) NSString * tweetMsg;
@property (nonatomic, retain) NSString * hostingService;
@property (nonatomic, retain) NSString * urlThumbnail;
@property (nonatomic, retain) NSString * urlLargest;
@property (nonatomic, retain) NSManagedObject * user;
@property (nonatomic, retain) DSChallenge * challenge;

@end



