//
//  DSUser.h
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class DSShot;

@interface DSUser :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * screenName;
@property (nonatomic, retain) NSDate * lastShot;
@property (nonatomic, retain) NSString * displayName;
@property (nonatomic, retain) NSNumber * numberShots;
@property (nonatomic, retain) NSString * twitterID;
@property (nonatomic, retain) NSSet* shots;

@end


@interface DSUser (CoreDataGeneratedAccessors)
- (void)addShotsObject:(DSShot *)value;
- (void)removeShotsObject:(DSShot *)value;
- (void)addShots:(NSSet *)value;
- (void)removeShots:(NSSet *)value;

@end

