//
//  DSDataListUsers.m
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 Reality Box Labs, LLC. All rights reserved.
//

#import "DSDataListUsers.h"


#import "DSDataStore.h"
#import "DSUser.h"

@implementation DSDataListUsers

-(id) init
{
	if ((self = [super init]))
	{
		self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Users" image:nil tag:0];
	}
	return self;
}


-(void) configureFetchController
{
	NSFetchRequest* fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	
	// Configure the request entity
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"DSUser" inManagedObjectContext:[DSDataStore sharedInstance].moContext]];
	
	NSSortDescriptor* sort = [[[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:YES] autorelease];
	NSArray* sortDesc = [[[NSArray alloc] initWithObjects:sort, nil] autorelease];
	
	[fetchRequest setSortDescriptors:sortDesc];
	
	self.fetchedResultsController = [[NSFetchedResultsController alloc]
									 initWithFetchRequest:fetchRequest
									 managedObjectContext:[DSDataStore sharedInstance].moContext
									 sectionNameKeyPath:nil
									 cacheName:@"usersCache"];
}

-(UITableViewCell*) createCell
{
	UITableViewCell* cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:_cellIdentifier] autorelease];
	
	return cell;
}

-(void) configureCell:(UITableViewCell*) cell atIndexPath:(NSIndexPath*)indexPath
{
    // Configure the cell...
	DSUser* user = (DSUser*)[_fetchedResultsController objectAtIndexPath:indexPath];
	
	// A timestamp format
//	static NSDateFormatter* gFormatter;
//	if (!gFormatter) 
//	{
//		gFormatter = [[NSDateFormatter alloc] init];
//		[gFormatter setDateFormat:@"MM/dd/YYYY"];
//	}
	//cell.textLabel.text = [NSString stringWithFormat:@"ds%d - %@", [challenge.number intValue], [gFormatter stringFromDate:challenge.appliesToDate]];

	cell.textLabel.text = [user displayName];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %d shots", user.screenName, [user.numberShots intValue]];
	
	//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	//cell.contentView.backgroundColor = [UIColor whiteColor];
	//cell.opaque = YES;
}

@end
