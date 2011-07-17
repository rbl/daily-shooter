//
//  DSChallenge.h
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface DSChallenge :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSDate * appliesToDate;
@property (nonatomic, retain) NSString * tweetID;
@property (nonatomic, retain) NSNumber * tweetMsg;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSSet* shots;

@end


@interface DSChallenge (CoreDataGeneratedAccessors)
- (void)addShotsObject:(NSManagedObject *)value;
- (void)removeShotsObject:(NSManagedObject *)value;
- (void)addShots:(NSSet *)value;
- (void)removeShots:(NSSet *)value;

@end

