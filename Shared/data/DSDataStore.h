//
//  DSDataStore.h
//  Daily-Shooter
//
//  Created by Tom Seago on 7/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DSDataStore : NSObject 
{
    
@private
    NSManagedObjectContext *_moContext;
    NSManagedObjectModel *_moModel;
    NSPersistentStoreCoordinator *_psCoordinator;
}

@property (nonatomic, readonly) NSManagedObjectContext *moContext;
@property (nonatomic, readonly) NSManagedObjectModel *moModel;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *psCoordinator;

@property (nonatomic, readonly) NSURL *storeURL;
@property (nonatomic, readonly) NSString *appDocDir;

//-(Project*) newProject;
-(BOOL) save;
-(void) generateSampleData;



+(DSDataStore*) sharedInstance;


@end
