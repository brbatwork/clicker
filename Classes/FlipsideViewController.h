//
//  FlipsideViewController.h
//  iClicker
//
//  Created by Bill Barbour on 3/7/10.
//  Copyright Sogra Software LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddEventViewController.h"

#define kOFFSET_FOR_KEYBOARD 140.0

@protocol FlipsideViewControllerDelegate;

@interface FlipsideViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddEventDelegate, UITextFieldDelegate> {
	id <FlipsideViewControllerDelegate> delegate;
	NSMutableArray *events;
	IBOutlet UITableView *theTableView;
	IBOutlet UIView *myFooterView;
	IBOutlet UITextField *resetTextField;
	NSString *pathToEventFile;
	int resetValue;
	NSInteger counter;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (retain, nonatomic) NSMutableArray *events;
@property (retain) NSString *pathToEventFile;
@property (nonatomic, retain) IBOutlet UIView *myFooterView;
@property (nonatomic, retain) IBOutlet UITextField *resetTextField;
@property (nonatomic, retain) IBOutlet UITableView *theTableView;
@property NSInteger counter;

- (IBAction) done;
- (IBAction) addEvent; 
- (void) persistEvents;
- (void) reloadTableData;
-(void)setViewMovedUp:(BOOL)movedUp;

@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

