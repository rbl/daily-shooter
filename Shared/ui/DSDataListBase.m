//
//  DSDataListBase.m
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 Reality Box Labs, LLC. All rights reserved.
//

#import "DSDataListBase.h"

@interface DSDataListBase()


@end

////////////////////////////////////////////////////


@implementation DSDataListBase

@synthesize tableView = _tableView;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize cellIdentifier = _cellIdentifier;

#pragma mark Lifecycle

-(id) init
{
	if ((self = [super init]))
	{
		self.cellIdentifier = @"cell";
	}
	return self;
}

-(void) dealloc
{
	self.tableView.delegate = nil;
	self.tableView = nil;

	self.fetchedResultsController.delegate = nil;
	self.fetchedResultsController = nil;

	[super dealloc];
}



#pragma mark -
#pragma mark View lifecycle

-(void)viewDidLoad 
{
    [super viewDidLoad];

	// Avoid the casting later
	self.tableView = (UITableView*)self.view;
	self.tableView.delegate = self;

	// Subclasses specify the request details
	[self configureFetchController];
	
	// Want to know how that works out ...
	_fetchedResultsController.delegate = self;
	
	NSError* error = nil;
	if (![_fetchedResultsController performFetch:&error]) {
		NSLog(@"Error with performFetch %@", error);
	}
	
	// Reload the data now that we have the fetched thing to query
	[self.tableView reloadData];
}

-(void)viewDidUnload
{
	self.fetchedResultsController.delegate = nil;
	self.fetchedResultsController = nil;
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/

-(void)viewDidAppear:(BOOL)animated 
{
    [super viewDidAppear:animated];
	
}



/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark Table view data source

// Return the number of sections.
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	if (!_fetchedResultsController) return 0;
	
    NSInteger num = [[_fetchedResultsController sections] count];
	return num;
}


// Return the number of rows in the section.
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	if (!_fetchedResultsController) return 0;
	
	id<NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    NSInteger num = [sectionInfo numberOfObjects];
	return num;
}


// Customize the appearance of table view cells.
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (cell == nil) 
	{
		cell = [self createCell];
    }
	
	// Get some datas for this cell
	[self configureCell:cell atIndexPath:indexPath];
	    
    return cell;
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	// Updating the background here manages to make the color apply to all the sub-views as well
//	cell.backgroundColor = [UIColor whiteColor];
//}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{ 
	id<NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo name];
}

-(NSArray*) sectionIndexTitlesForTableView:(UITableView *)tableView 
{
    return [_fetchedResultsController sectionIndexTitles];
}

-(NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index 
{
    return [_fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSLog(@"did select row at index path %@", [indexPath description]);
}



#pragma mark NSFetchedResultsControllerDelegate

-(void) controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}


-(void) controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type 
{	
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
						  withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
						  withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


-(void) controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath 
{
	
    UITableView *tableView = self.tableView;
	
    switch(type) {
			
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
							 withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
							 withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath]
					atIndexPath:indexPath];
            break;
			
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
							 withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
							 withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller 
{
    [self.tableView endUpdates];
}

#pragma mark -
#pragma mark For subclasses to implement

-(void) configureFetchController
{
	NSLog(@"WARNING: configureFetchController called in DSDataListBase.m. You probably don't want this");
}

-(UITableViewCell*) createCell
{
	NSLog(@"WARNING: createCell called in DSDataListBase.m. You probably don't want this");
	return nil;
}

-(void) configureCell:(UITableViewCell*) cell atIndexPath:(NSIndexPath*)indexPath
{
    // Configure the cell...
	NSLog(@"You probably wanted to configure the cell in the subclass.....");
}

@end

