//
//  DSImageGridController.h
//  Daily-Shooter
//
//  Created by Tom Seago on 7/16/11.
//  Copyright 2011 Reality Box Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DSImageGridPopoverDelegate<NSObject>

-(void) showPopover:(UIBarButtonItem*)item;
-(void) hidePopover;

@end


@interface DSImageGridController : UIViewController {
	id<DSImageGridPopoverDelegate> _popoverDelegate;
	UINavigationBar* _navBar;
	UINavigationItem* _navItem;
	UIBarButtonItem* _collectionsButtonItem;
}

@property (nonatomic, assign) id<DSImageGridPopoverDelegate> popoverDelegate;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UINavigationItem *navItem;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *collectionsButtonItem;

-(IBAction) colAction:(id)sender;

@end
