//
//  DSDataStore.m
//  Daily-Shooter
//
//  Created by Tom Seago on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DSDataStore.h"
#import "SynthesizeSingleton.h"

#import "DSChallenge.h"
#import "DSUser.h"
#import "DSShot.h"

@implementation DSDataStore

SYNTHESIZE_SINGLETON_FOR_CLASS(DSDataStore);

#pragma mark -
#pragma mark Lifecycle

-(id) init
{
    if ((self = [super init]))
    {
        // whateves ...
    }
    return self;
}

-(void) dealloc
{
    [_moContext release];
    [_moModel release];
    [_psCoordinator release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark Accessors

-(NSManagedObjectContext *) moContext
{
    if (_moContext) return _moContext;
    
    NSPersistentStoreCoordinator *coordinator = self.psCoordinator;
    if (coordinator)
    {
        _moContext = [[NSManagedObjectContext alloc] init];
        _moContext.persistentStoreCoordinator = coordinator;
    }
    return _moContext;
}

-(NSManagedObjectModel *) moModel
{
    if (_moModel) return _moModel;
    
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"Daily_Shooter" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    _moModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _moModel;
}

-(NSPersistentStoreCoordinator *) psCoordinator
{
    if (_psCoordinator) return _psCoordinator;
    
    NSError *error = nil;
    _psCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.moModel];
    if (![_psCoordinator addPersistentStoreWithType:NSSQLiteStoreType 
                                      configuration:nil
                                                URL:self.storeURL 
                                            options:nil
                                              error:&error]) 
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _psCoordinator;
}

-(NSString *) appDocDir
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

-(NSURL*) storeURL
{
    return [NSURL fileURLWithPath: [[self appDocDir] stringByAppendingPathComponent: @"ds.sqlite"]];
}

#pragma mark -
#pragma mark Object Utilities

//- (Project*)newProject
//{
//    NSEntityDescription *entity = [[self.moModel entitiesByName] objectForKey:@"Project"];
//    Project* project = [[NSManagedObject alloc]
//						initWithEntity:entity insertIntoManagedObjectContext:self.moContext];
//    
//    // Initial data
//    project.createdAt = [NSDate date];
//    project.name = @"Untitled";
//    
//    return project;
//}

-(BOOL) save
{
    NSError *error = nil;
    
    BOOL didSave = [self.moContext save:&error];
    if (!didSave && error)
    {
        NSLog(@"Error during save %@ - %@",error, [error userInfo]);
    }
    
    return didSave;
}

//-(void) alertOnStart {
//	AZMBoxEntry* entry = [NSEntityDescription
//						  insertNewObjectForEntityForName:@"AZMBoxEntry"
//						  inManagedObjectContext:self.moContext];
//	
//	entry.timestamp = [NSDate date];
//	entry.kind = [NSNumber numberWithInt:1];
//	entry.mboxId = [[NSDate date] description];
//	entry.alertText = @"App Started E";
//	entry.alertLevel = [NSNumber numberWithInt:2000];
//	
//	[self save];
//}

-(void) generateSampleData
{
	DSUser* user = [NSEntityDescription insertNewObjectForEntityForName:@"DSUser" inManagedObjectContext:self.moContext];
	
	/*
	 
	 @property (nonatomic, retain) NSString * screenName;
	 @property (nonatomic, retain) NSDate * lastShot;
	 @property (nonatomic, retain) NSString * displayName;
	 @property (nonatomic, retain) NSNumber * numberShots;
	 @property (nonatomic, retain) NSString * twitterID;
	 @property (nonatomic, retain) NSSet* shots;
		*/
	
	user.screenName = @"testOne";
	user.lastShot = [NSDate dateWithTimeIntervalSinceNow:-3600];
	user.displayName = @"Test One";
	user.numberShots = [NSNumber numberWithInt:12];
	user.twitterID = @"11111111";
	
	DSUser* user2 = [NSEntityDescription insertNewObjectForEntityForName:@"DSUser" inManagedObjectContext:self.moContext];
	user2.screenName = @"testTwo";
	user2.lastShot = [NSDate dateWithTimeIntervalSinceNow:-7200];
	user2.displayName = @"Test Two";
	user2.numberShots = [NSNumber numberWithInt:22];
	user2.twitterID = @"222222222";
	
	/*
	 @property (nonatomic, retain) NSNumber * number;
	 @property (nonatomic, retain) NSDate * appliesToDate;
	 @property (nonatomic, retain) NSString * tweetID;
	 @property (nonatomic, retain) NSNumber * tweetMsg;
	 @property (nonatomic, retain) NSString * text;
	 @property (nonatomic, retain) NSSet* shots;
		*/
	
	DSChallenge* cha1 = [NSEntityDescription insertNewObjectForEntityForName:@"DSChallenge" inManagedObjectContext:self.moContext];
	cha1.number = [NSNumber numberWithInt:1];
	cha1.appliesToDate = [NSDate dateWithTimeIntervalSinceNow:-(48*3600)];
	cha1.text = @"The first challenge";
	
	DSChallenge* cha2 = [NSEntityDescription insertNewObjectForEntityForName:@"DSChallenge" inManagedObjectContext:self.moContext];
	cha2.number = [NSNumber numberWithInt:2];
	cha2.appliesToDate = [NSDate dateWithTimeIntervalSinceNow:-(24*3600)];
	cha2.text = @"The second challenge";
	
	DSChallenge* cha3 = [NSEntityDescription insertNewObjectForEntityForName:@"DSChallenge" inManagedObjectContext:self.moContext];
	cha3.number = [NSNumber numberWithInt:3];
	cha3.appliesToDate = [NSDate dateWithTimeIntervalSinceNow:0];
	cha3.text = @"The third challenge";
	
	
	[self save];
}


@end
