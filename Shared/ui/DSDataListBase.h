//
//  DSDataListBase.h
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 Reality Box Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface DSDataListBase : UITableViewController <NSFetchedResultsControllerDelegate>{
	UITableView *_tableView;
	
	NSFetchedResultsController* _fetchedResultsController;
	NSString* _cellIdentifier;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSString *cellIdentifier;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

-(void) configureFetchController;
-(UITableViewCell*) createCell;
-(void) configureCell:(UITableViewCell*) cell atIndexPath:(NSIndexPath*)indexPath;


@end
