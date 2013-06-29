//
//  FlipsideViewController.m
//  iClicker
//
//  Created by Bill Barbour on 3/7/10.
//  Copyright Sogra Software LLC 2010. All rights reserved.
//

#import "FlipsideViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation FlipsideViewController

@synthesize delegate;
@synthesize events;
@synthesize pathToEventFile;
@synthesize myFooterView;
@synthesize resetTextField;
@synthesize theTableView;
@synthesize counter;

-(id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle {
	self = [super initWithNibName:nibName bundle:nibBundle];
	
	if (self) {
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *docsDir = [paths objectAtIndex:0];
		
		NSFileManager *nfm = [NSFileManager defaultManager];
		self.pathToEventFile = [docsDir stringByAppendingPathComponent:@"Events.plist"];
		
		if ([nfm fileExistsAtPath: pathToEventFile]) {
			self.events = [[NSMutableArray alloc] initWithContentsOfFile: pathToEventFile];
		} else {
			self.events = [[NSMutableArray alloc] init];
		}
		
		NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
		resetValue = [userPreferences integerForKey:@"resetValue"];		
	}
	
	return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
	self.theTableView.layer.cornerRadius = 15;
	self.theTableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];

	// set up the table's footer view based on our UIView 'myFooterView' outlet
	CGRect newFrame = CGRectMake(0.0, 0.0, theTableView.bounds.size.width, self.myFooterView.frame.size.height);
	self.myFooterView.backgroundColor = [UIColor clearColor];
	self.myFooterView.frame = newFrame;
	self.theTableView.tableFooterView = self.myFooterView;	// note this will override UITableView's 'sectionFooterHeight' property
	
	self.resetTextField.text = [NSString stringWithFormat:@"%i", resetValue];
	self.resetTextField.delegate = self;
}

- (IBAction)done {
	[self.delegate flipsideViewControllerDidFinish:self];	
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	self.myFooterView = nil;
	self.resetTextField = nil;
	self.theTableView = nil;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)dealloc {
	[pathToEventFile release];
	[events release];
	[resetTextField release];
	[myFooterView release];
	[theTableView release];
    [super dealloc];
}

-(IBAction) addEvent {
	AddEventViewController *controller = [[AddEventViewController alloc] initWithNibName:@"AddEventView" bundle:nil];
	UINavigationController *addEventNavController = [[UINavigationController alloc] initWithRootViewController:controller];
	controller.delegate = self;
	[self presentModalViewController:addEventNavController animated:YES];
	[controller release];
	[addEventNavController release];
}

-(NSInteger) retrieveCounter {
	return counter;
}

#pragma mark -
#pragma mark Table View DataSource Methods

-(NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section {
	return [self.events count];
}

-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {
	static NSString *cellIdentifier = @"EventCellIdentifier";
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellIdentifier] autorelease];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
	}
	
	cell.textLabel.text = [self.events objectAtIndex:[indexPath row]];

	return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{	
		[self.events removeObjectAtIndex:[indexPath row]];
		[self persistEvents];
		[theTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		[self reloadTableData];
	}	
}

- (void) reloadTableData {
	[theTableView reloadData];
}

#pragma mark -
#pragma mark Keyboard methods

-(BOOL) shouldMoveTextField {
	return [self.events count] > 3;
}
-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:self.resetTextField] && self.shouldMoveTextField)
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5]; // if you want to slide up the view
	
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
	
    [UIView commitAnimations];
}

-(void) doneButton: (id) sender {
	[self.resetTextField resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)notif {
	// create custom button
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 163, 106, 53);
    doneButton.adjustsImageWhenHighlighted = NO;
    [doneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
    [doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
	
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIView* keyboard;

    for(int i=0; i<[tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        // keyboard view found; add the custom button to it
        if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
            [keyboard addSubview:doneButton];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)sender {
	if (self.shouldMoveTextField) {
		if  (self.view.frame.origin.y < 0) {
			[self setViewMovedUp:NO];
		}	
	}
	
	//Saving the new Reset Value
	NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
	[userPreferences setInteger:[[resetTextField text] intValue] forKey:@"resetValue"];
}

- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) 
												 name:UIKeyboardWillShowNotification object:self.view.window]; 
}

- (void)viewWillDisappear:(BOOL)animated
{
	// unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil]; 
}

#pragma mark -
#pragma mark Add Event Methods

-(void) addEventViewControllerDidSave:(AddEventViewController *) controller withDescription: (NSString *) description {
	[self.events addObject:[NSString stringWithFormat:@"%i %@", self.counter, description]];
	[self persistEvents];
	[self reloadTableData];
	[self dismissModalViewControllerAnimated:YES];
}

-(void) addEventViewControllerDidCancel: (AddEventViewController *) controller {
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Persistance

- (void) persistEvents {
	[self.events writeToFile:pathToEventFile atomically:YES];
}

@end
