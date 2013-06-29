//
//  AddEventViewController.m
//  iClicker
//
//  Created by Bill Barbour on 3/10/10.
//  Copyright 2010 Sogra Software LLC. All rights reserved.
//

#import "AddEventViewController.h"

@implementation AddEventViewController
@synthesize delegate;
@synthesize eventDescription;
@synthesize theValue;

-(void) viewDidLoad {
	cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAddEvent:)];
	saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonSystemItemCancel target:self action:@selector(saveEvent:)];
	self.navigationItem.leftBarButtonItem = cancelButton;
	self.navigationItem.rightBarButtonItem = saveButton;
	self.theValue.text = [NSString stringWithFormat:@"%i", [self.delegate retrieveCounter]];
}

-(void) cancelAddEvent: (id) sender {
	[self.delegate addEventViewControllerDidCancel: self];
}

-(void) saveEvent: (id) sender {
	[self.delegate addEventViewControllerDidSave:self withDescription: [self.eventDescription text]];
}

- (BOOL)textFieldShouldReturn:(UITextField *) textField {
	[textField resignFirstResponder];	
	return YES;
}

-(void) dealloc {
	[cancelButton release];
	[saveButton release];
	[theValue release];
	[super dealloc];
}
@end
