//
//  DSDataListChallenges.m
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 Reality Box Labs, LLC. All rights reserved.
//

#import "DSDataListChallenges.h"

#import "DSDataStore.h"
#import "DSChallenge.h"

@implementation DSDataListChallenges

-(id) init
{
	if ((self = [super init]))
	{
		self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Challenges" image:nil tag:0];
	}
	return self;
}

-(void) configureFetchController
{
	NSFetchRequest* fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
	
	// Configure the request entity
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"DSChallenge" inManagedObjectContext:[DSDataStore sharedInstance].moContext]];
	
	NSSortDescriptor* sort = [[[NSSortDescriptor alloc] initWithKey:@"number" ascending:NO] autorelease];
	NSArray* sortDesc = [[[NSArray alloc] initWithObjects:sort, nil] autorelease];
	
	[fetchRequest setSortDescriptors:sortDesc];
	
	self.fetchedResultsController = [[NSFetchedResultsController alloc]
									 initWithFetchRequest:fetchRequest
									 managedObjectContext:[DSDataStore sharedInstance].moContext
									 sectionNameKeyPath:nil
									 cacheName:@"challengesCache"];
}

-(UITableViewCell*) createCell
{
	UITableViewCell* cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:_cellIdentifier] autorelease];
	
	return cell;
}

-(void) configureCell:(UITableViewCell*) cell atIndexPath:(NSIndexPath*)indexPath
{
    // Configure the cell...
	DSChallenge* challenge = (DSChallenge*)[_fetchedResultsController objectAtIndexPath:indexPath];
	
//	NSString* imgName = [NSString stringWithFormat:@"%@.png", entry.levelStr];
//	cell.imageView.image = [UIImage imageNamed:imgName];

	// A timestamp format
	static NSDateFormatter* gFormatter;
	if (!gFormatter) 
	{
		gFormatter = [[NSDateFormatter alloc] init];
		[gFormatter setDateFormat:@"MM/dd/YYYY"];
	}
	cell.textLabel.text = [NSString stringWithFormat:@"ds%d - %@", [challenge.number intValue], [gFormatter stringFromDate:challenge.appliesToDate]];

	cell.detailTextLabel.text = challenge.text;
	
	//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	//cell.contentView.backgroundColor = [UIColor whiteColor];
	//cell.opaque = YES;
}

@end
