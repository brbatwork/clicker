//
//  MainViewController.m
//  iClicker
//
//  Created by Bill Barbour on 3/7/10.
//  Copyright Sogra Software LLC 2010. All rights reserved.
//

#import "MainViewController.h"


@implementation MainViewController
@synthesize up;
@synthesize down;
@synthesize reset;
@synthesize theValue;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
		NSInteger value = [userPreferences integerForKey:@"counterValue"];
		counter = value;
		resetPresses = 0;
		upClick = [[Sounds alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"penclick" ofType:@"caf"]];
		downClick = [[Sounds alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"click2" ofType:@"caf"]];
    }
    return self;
}

- (void)viewDidLoad {
	[self.theValue setText: [NSString stringWithFormat:@"%i", counter]];
	[super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated {
	NSUserDefaults *userPreferences = [NSUserDefaults standardUserDefaults];
	resetValue = [userPreferences integerForKey:@"resetValue"];
}

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction)showInfo {    
	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	controller.counter = counter;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}

- (IBAction) showResetHint: (id) sender {
	[self performSelector:@selector(singleTapOnButton:) withObject:sender afterDelay:0.2];
}

- (void) singleTapOnButton: (id) sender {
	if (resetPresses++ > 1) {
		UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle:NSLocalizedString(@"Hint", @"Hint for Double tapping reset button")
							  message:NSLocalizedString(@"Double tap the Reset button to set the value", @"Double tap reset button")
							  delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
		[alert show];
		[alert release];
		resetPresses = 0;
	}
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	self.up = nil;
	self.down = nil;
	self.theValue = nil;
	self.reset = nil;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction) increment {
	counter++;
	[self.theValue setText: [NSString stringWithFormat:@"%i", counter]]; 
	[upClick play];

}
- (IBAction) decrement {	 
	counter--;
	[self.theValue setText: [NSString stringWithFormat:@"%i", counter]];
	[downClick play];
}

- (IBAction) resetCounter: (id) sender {
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleTapOnButton:) object:sender];
	resetPresses = -1;
	counter = resetValue;
	[self.theValue setText: [NSString stringWithFormat:@"%i", counter]]; 
}

- (void)dealloc {
	[theValue release];
	[up release];
	[down release];
	[reset release];
	[upClick release];
	[downClick release];
    [super dealloc];
}


@end
